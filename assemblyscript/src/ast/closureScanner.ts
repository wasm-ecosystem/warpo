import { BaseVisitor } from "./visitor";
import {
  BlockStatement,
  DoStatement,
  ForOfStatement,
  ForStatement,
  FunctionDeclaration,
  IdentifierExpression,
  IfStatement,
  Node,
  SwitchCase,
  VariableDeclaration,
  WhileStatement,
} from "../ast";

class VariableMark {
  get node(): VariableDeclaration {
    return this.node_;
  }
  get isCaptured(): bool {
    return this.isCaptured_;
  }
  constructor(node: VariableDeclaration) {
    this.node_ = node;
    this.isCaptured_ = false;
  }
  private node_: VariableDeclaration;
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

  addVariableDeclaration(node: VariableDeclaration): void {
    this.variables_.set(node.name.text, new VariableMark(node));
  }

  markVariableCaptured(name: string): void {
    const variableMark = this.variables_.get(name);
    if (variableMark) {
      variableMark.markCaptured();
    }
  }
  findVariable(name: string): VariableMark | null {
    return this.variables_.get(name);
  }
}

class FunctionScope {
  private node_: FunctionDeclaration;
  private isClosureFunction_: bool;
  get node(): FunctionDeclaration {
    return this.node_;
  }
  get isClosureFunction(): bool {
    return this.isClosureFunction_;
  }
  get scopeStack(): Scope[] {
    return this.scopeStack_;
  }
  constructor(node: FunctionDeclaration) {
    this.node_ = node;
    this.isClosureFunction_ = false;
    this.scopeStack_ = new Array();
    this.scopeStack_.push(new Scope());
  }
  private scopeStack_: Scope[];

  pushScope(): void {
    this.scopeStack_.push(new Scope());
  }

  popScope(): void {
    this.scopeStack_.pop();
  }

  addVariableDeclaration(node: VariableDeclaration): void {
    const currentScope = this.scopeStack_[this.scopeStack_.length - 1];
    currentScope.addVariableDeclaration(node);
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
      this.markAsClosureFunction();
      return true;
    }
  }

  markAsClosureFunction(): void {
    this.isClosureFunction_ = true;
  }
}

class FunctionScopeChain {
  private functionScopes_: FunctionScope[];
  private closureFunctions_: Set<FunctionDeclaration>;
  private closureVariables_: Set<VariableDeclaration>;

  constructor(closureFunctions: Set<FunctionDeclaration>, closureVariables: Set<VariableDeclaration>) {
    this.closureFunctions_ = closureFunctions;
    this.closureVariables_ = closureVariables;
    this.functionScopes_ = new Array();
  }

  enterFunction(node: FunctionDeclaration): void {
    const scope = new FunctionScope(node);
    this.functionScopes_.push(scope);
  }
  leaveFunction(): void {
    assert(this.functionScopes_.length > 0, "leaveFunction should be called within a function");
    const lastFunctionScope = this.functionScopes_[this.functionScopes_.length - 1];
    if (lastFunctionScope.isClosureFunction) {
      this.closureFunctions_.add(lastFunctionScope.node);
      for (let i = 0; i < lastFunctionScope.scopeStack.length; i++) {
        const scope = lastFunctionScope.scopeStack[i];
        for (let keys = scope.variables.keys(), j = 0, k = keys.length; j < k; j++) {
          const variableMark = assert(scope.variables.get(keys[j]));
          if (variableMark.isCaptured) {
            this.closureVariables_.add(variableMark.node);
          }
        }
      }
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
        return true;
      }
    }
    return false;
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
  private closureFunctions_: Set<FunctionDeclaration>;
  private closureVariables_: Set<VariableDeclaration>;
  private functionScopeChain_: FunctionScopeChain;

  get closureFunctions(): Set<FunctionDeclaration> {
    return this.closureFunctions_;
  }

  get closureVariables(): Set<VariableDeclaration> {
    return this.closureVariables_;
  }

  constructor() {
    super();
    const closureFunctions = new Set<FunctionDeclaration>();
    const closureVariables = new Set<VariableDeclaration>();
    this.closureFunctions_ = closureFunctions;
    this.closureVariables_ = closureVariables;
    this.functionScopeChain_ = new FunctionScopeChain(closureFunctions, closureVariables);
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

  visitVariableDeclaration(node: VariableDeclaration): void {
    this.functionScopeChain_.addVariableDeclaration(node);
    super.visitVariableDeclaration(node);
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

  visitIdentifierExpression(node: IdentifierExpression): void {
    const isClosureVariable = this.functionScopeChain_.checkAndMarkClosureVariable(node.text);
    if (isClosureVariable) {
      // If the a function used a closure variable
      this.functionScopeChain_.markCurrentFunctionAsClosure();
    }
  }
}
