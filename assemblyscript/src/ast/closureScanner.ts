import { BaseVisitor } from "./visitor";
import {
  BlockStatement,
  DeclarationStatement,
  DoStatement,
  ForOfStatement,
  ForStatement,
  FunctionDeclaration,
  IdentifierExpression,
  IfStatement,
  MethodDeclaration,
  Node,
  ParameterNode,
  SwitchCase,
  ThisExpression,
  TypeDeclaration,
  VariableDeclaration,
  WhileStatement,
} from "../ast";

class VariableMark {
  get node(): Node {
    return this.node_;
  }
  get isCaptured(): bool {
    return this.isCaptured_;
  }
  constructor(node: Node) {
    this.node_ = node;
    this.isCaptured_ = false;
  }
  private node_: Node;
  private isCaptured_: bool;

  markCaptured(): void {
    this.isCaptured_ = true;
  }
}

class Scope {
  private variables_: Map<string, VariableMark> = new Map();

  get variables(): Map<string, VariableMark> {
    return this.variables_;
  }

  addVariable(name: string, node: Node): void {
    this.variables_.set(name, new VariableMark(node));
  }

  findVariable(name: string): VariableMark | null {
    if (this.variables_.has(name)) {
      return this.variables_.get(name);
    } else {
      return null;
    }
  }
}

class FunctionScope {
  private node_: DeclarationStatement;
  private isClosureFunction_: bool;
  private closureVariables_: Set<Node>;
  private hasThis_: bool;
  private capturesThis_: bool;
  get node(): DeclarationStatement {
    return this.node_;
  }
  get isClosureFunction(): bool {
    return this.isClosureFunction_;
  }
  get closureVariables(): Set<Node> {
    return this.closureVariables_;
  }
  get hasThis(): bool {
    return this.hasThis_;
  }
  get capturesThis(): bool {
    return this.capturesThis_;
  }
  constructor(node: DeclarationStatement) {
    this.node_ = node;
    this.isClosureFunction_ = false;
    this.closureVariables_ = new Set();
    this.hasThis_ = node instanceof MethodDeclaration; // both instance and static methods have `this`
    this.capturesThis_ = false;
    this.scopeStack_ = new Array();
    this.scopeStack_.push(new Scope());
  }
  private scopeStack_: Scope[];

  pushScope(): void {
    this.scopeStack_.push(new Scope());
  }

  popScope(): void {
    assert(this.scopeStack_.length > 0, "popScope called on empty scope stack");
    const scope = this.scopeStack_[this.scopeStack_.length - 1];
    for (let keys = scope.variables.keys(), j = 0, k = keys.length; j < k; j++) {
      const variableMark = assert(scope.variables.get(keys[j]));
      if (variableMark.isCaptured) {
        this.closureVariables_.add(variableMark.node);
      }
    }
    this.scopeStack_.pop();
  }

  addVariableDeclaration(node: VariableDeclaration): void {
    assert(this.scopeStack_.length > 0, "addVariableDeclaration should be called within a scope");
    this.scopeStack_[this.scopeStack_.length - 1].addVariable(node.name.text, node);
  }

  addParameter(node: ParameterNode): void {
    assert(this.scopeStack_.length > 0, "addParameter should be called within a scope");
    this.scopeStack_[0].addVariable(node.name.text, node);
  }

  findVariable(name: string): VariableMark | null {
    for (let i = this.scopeStack_.length - 1; i >= 0; i--) {
      const scope = this.scopeStack_[i];
      const variableMark = scope.findVariable(name);
      if (variableMark) {
        return variableMark;
      }
    }
    return null;
  }

  markVariableCapturedIfExists(name: string): bool {
    const variableDeclaration = this.findVariable(name);
    if (variableDeclaration == null) {
      return false;
    } else {
      variableDeclaration.markCaptured();
      return true;
    }
  }

  markAsClosureFunction(): void {
    this.isClosureFunction_ = true;
  }

  markCapturesThis(): void {
    this.capturesThis_ = true;
  }
}

export class ClosureFunctionInfo {
  closureVariables: Set<Node> = new Set();
  capturesThis: bool = false;
  nestedLevel: i32 = 0;
}

class FunctionScopeChain {
  private functionScopes_: FunctionScope[];
  private closureFunctions_: Map<DeclarationStatement, ClosureFunctionInfo>;

  constructor(closureFunctions: Map<DeclarationStatement, ClosureFunctionInfo>) {
    this.closureFunctions_ = closureFunctions;
    this.functionScopes_ = new Array();
  }

  enterFunction(node: DeclarationStatement): void {
    const scope = new FunctionScope(node);
    this.functionScopes_.push(scope);
  }
  leaveFunction(): void {
    assert(this.functionScopes_.length > 0, "leaveFunction should be called within a function");
    const lastFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    lastFunctionScope.popScope(); // collect captures from scope[0] (parameters + root-level vars)
    if (lastFunctionScope.isClosureFunction) {
      const info = new ClosureFunctionInfo();
      info.closureVariables = lastFunctionScope.closureVariables;
      info.capturesThis = lastFunctionScope.capturesThis;
      info.nestedLevel = this.functionScopes_.length - 1;
      this.closureFunctions_.set(lastFunctionScope.node, info);
    }
    this.functionScopes_.pop();
  }

  enterScope(): void {
    if (this.functionScopes_.length === 0) return;
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    currentFunctionScope.pushScope();
  }

  leaveScope(): void {
    if (this.functionScopes_.length === 0) return;
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    currentFunctionScope.popScope();
  }

  addVariableDeclaration(node: VariableDeclaration): void {
    if (this.functionScopes_.length === 0) return;
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    currentFunctionScope.addVariableDeclaration(node);
  }

  addParameterDeclaration(node: ParameterNode): void {
    if (this.functionScopes_.length === 0) return;
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    currentFunctionScope.addParameter(node);
  }

  checkAndMarkClosureVariable(name: string): bool {
    if (this.functionScopes_.length === 0) {
      return false;
    }
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    if (currentFunctionScope.findVariable(name) !== null) {
      // If the variable is declared in the current function, it's not a closure variable.
      return false;
    }

    if (this.functionScopes_.length < 2) {
      // closure must has at least 2 function scopes
      return false;
    }
    for (let i = this.functionScopes_.length - 2; i >= 0; i--) {
      const functionScope = this.functionScopes_[i];
      if (functionScope.markVariableCapturedIfExists(name)) {
        this.markRangeAsClosureFunction(i);
        return true;
      }
    }
    return false;
  }

  checkAndMarkCapturedThis(): bool {
    if (this.functionScopes_.length === 0) return false;
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    if (currentFunctionScope.hasThis) return false;

    if (this.functionScopes_.length < 2) return false;
    for (let i = this.functionScopes_.length - 2; i >= 0; i--) {
      const functionScope = this.functionScopes_[i];
      if (functionScope.hasThis) {
        functionScope.markCapturesThis();
        this.markRangeAsClosureFunction(i);
        return true;
      }
    }
    return false;
  }

  private markRangeAsClosureFunction(start: i32): void {
    for (let i = start; i < this.functionScopes_.length; i++) {
      this.functionScopes_[i].markAsClosureFunction();
    }
  }

  markCurrentFunctionAsClosure(): void {
    if (this.functionScopes_.length === 0) return;
    const currentFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    currentFunctionScope.markAsClosureFunction();
  }

  get functionScopesLength(): i32 {
    return this.functionScopes_.length;
  }
}

export class ClosureScanner extends BaseVisitor {
  private closureFunctions_: Map<DeclarationStatement, ClosureFunctionInfo>;
  private functionScopeChain_: FunctionScopeChain;

  get closureFunctions(): Map<DeclarationStatement, ClosureFunctionInfo> {
    return this.closureFunctions_;
  }

  constructor() {
    super();
    const closureFunctions = new Map<DeclarationStatement, ClosureFunctionInfo>();
    this.closureFunctions_ = closureFunctions;
    this.functionScopeChain_ = new FunctionScopeChain(closureFunctions);
  }

  getClosureFunctionInfo(node: DeclarationStatement): ClosureFunctionInfo | null {
    if (this.closureFunctions_.has(node)) {
      return this.closureFunctions_.get(node);
    } else {
      return null;
    }
  }

  getCapturedVariablesOfFunction(node: DeclarationStatement): Set<Node> | null {
    const info = this.getClosureFunctionInfo(node);
    return info ? info.closureVariables : null;
  }

  private visitNodeInScope(node: Node | null): void {
    if (!node) return;
    this.functionScopeChain_.enterScope();
    this.visitNode(node);
    this.functionScopeChain_.leaveScope();
  }

  visitFunctionDeclaration(node: FunctionDeclaration): void {
    this.functionScopeChain_.enterFunction(node);
    super.visitFunctionDeclaration(node);
    this.functionScopeChain_.leaveFunction();
  }

  visitMethodDeclaration(node: MethodDeclaration): void {
    this.functionScopeChain_.enterFunction(node);
    super.visitMethodDeclaration(node);
    this.functionScopeChain_.leaveFunction();
  }

  visitVariableDeclaration(node: VariableDeclaration): void {
    this.functionScopeChain_.addVariableDeclaration(node);
    super.visitVariableDeclaration(node);
  }

  visitParameterNode(node: ParameterNode): void {
    this.functionScopeChain_.addParameterDeclaration(node);
    this.visitNode(node.name);
    // Skip node.type: when the type is a FunctionTypeNode (e.g. `(value: Object) => void`),
    // visiting it would trigger visitParameterNode for its parameters, incorrectly
    // registering type-annotation parameter names as variable declarations in the scope.
    this.visitNode(node.initializer);
  }

  visitBlockStatement(node: BlockStatement): void {
    this.functionScopeChain_.enterScope();
    super.visitBlockStatement(node);
    this.functionScopeChain_.leaveScope();
  }

  visitIfStatement(node: IfStatement): void {
    this.visitNode(node.condition);
    this.visitNodeInScope(node.ifTrue);
    this.visitNodeInScope(node.ifFalse);
  }

  visitForStatement(node: ForStatement): void {
    // Outer scope covers the initializer (e.g. `let i = 0`) and body.
    this.functionScopeChain_.enterScope();
    super.visitForStatement(node);
    this.functionScopeChain_.leaveScope();
  }

  visitForOfStatement(node: ForOfStatement): void {
    // Outer scope covers the iteration variable and body.
    this.functionScopeChain_.enterScope();
    super.visitForOfStatement(node);
    this.functionScopeChain_.leaveScope();
  }

  visitWhileStatement(node: WhileStatement): void {
    this.functionScopeChain_.enterScope();
    super.visitWhileStatement(node);
    this.functionScopeChain_.leaveScope();
  }

  visitDoStatement(node: DoStatement): void {
    this.functionScopeChain_.enterScope();
    super.visitDoStatement(node);
    this.functionScopeChain_.leaveScope();
  }

  visitSwitchCase(node: SwitchCase): void {
    this.functionScopeChain_.enterScope();
    super.visitSwitchCase(node);
    this.functionScopeChain_.leaveScope();
  }

  visitTypeDeclaration(node: TypeDeclaration): void {
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.type);
  }

  visitIdentifierExpression(node: IdentifierExpression): void {
    this.functionScopeChain_.checkAndMarkClosureVariable(node.text);
  }

  visitThisExpression(node: ThisExpression): void {
    this.functionScopeChain_.checkAndMarkCapturedThis();
  }
}
