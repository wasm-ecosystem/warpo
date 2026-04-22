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
  NodeKind,
  ParameterNode,
  SwitchCase,
  ThisExpression,
  TypeDeclaration,
  VariableDeclaration,
  VariableStatement,
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

class BlockScope {
  private node_: Node;
  private isFunction_: bool;
  private isClosure_: bool;
  private closureVariables_: Set<Node>;
  private hasThis_: bool;
  private capturesThis_: bool;
  get node(): Node {
    return this.node_;
  }
  get isFunction(): bool {
    return this.isFunction_;
  }
  get isClosure(): bool {
    return this.isClosure_;
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
  constructor(node: Node, isFunction: bool) {
    this.node_ = node;
    this.isFunction_ = isFunction;
    this.isClosure_ = false;
    this.closureVariables_ = new Set();
    this.hasThis_ = isFunction && node instanceof MethodDeclaration;
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

  markAsClosure(): void {
    this.isClosure_ = true;
  }

  markCapturesThis(): void {
    this.capturesThis_ = true;
  }
}

export class ClosureFunctionInfo {
  closureVariables: Set<Node> = new Set();
  forInitClosureVariables: Set<Node> = new Set();
  capturesThis: bool = false;
  nestedLevel: i32 = 0;
}

class BlockScopeChain {
  private blockScopes_: BlockScope[];
  private closureScopes_: Map<Node, ClosureFunctionInfo>;
  private pendingClosureInfos_: ClosureFunctionInfo[];

  constructor(closureScopes: Map<Node, ClosureFunctionInfo>) {
    this.closureScopes_ = closureScopes;
    this.blockScopes_ = new Array();
    this.pendingClosureInfos_ = new Array();
  }

  enterFunction(node: DeclarationStatement): void {
    this.blockScopes_.push(new BlockScope(node, true));
  }

  leaveFunction(): void {
    assert(this.blockScopes_.length > 0, "leaveFunction should be called within a block scope");
    const last = this.blockScopes_[this.blockScopes_.length - 1];
    assert(last.isFunction, "leaveFunction called on non-function block scope");
    last.popScope();
    if (last.isClosure) {
      const info = new ClosureFunctionInfo();
      info.closureVariables = last.closureVariables;
      info.capturesThis = last.capturesThis;
      info.nestedLevel = this.blockScopes_.length - 1;
      this.closureScopes_.set(last.node, info);
      this.pendingClosureInfos_.push(info);
    }
    this.blockScopes_.pop();
    if (this.blockScopes_.length == 0) {
      this.assignNestedLevels();
    }
  }

  enterLoop(node: Node): void {
    this.blockScopes_.push(new BlockScope(node, false));
  }

  leaveLoop(): void {
    assert(this.blockScopes_.length > 0, "leaveLoop should be called within a block scope");
    const last = this.blockScopes_[this.blockScopes_.length - 1];
    assert(!last.isFunction, "leaveLoop called on function block scope");
    last.popScope();
    if (last.isClosure && last.closureVariables.size > 0) {
      const info = new ClosureFunctionInfo();
      info.closureVariables = last.closureVariables;
      info.capturesThis = last.capturesThis;
      info.nestedLevel = this.blockScopes_.length - 1;
      const loopNode = last.node;
      if (loopNode.kind == NodeKind.For) {
        const initializer = (<ForStatement>loopNode).initializer;
        if (initializer && initializer.kind == NodeKind.Variable) {
          const decls = (<VariableStatement>initializer).declarations;
          for (let d = 0; d < decls.length; d++) {
            if (info.closureVariables.has(decls[d])) info.forInitClosureVariables.add(decls[d]);
          }
        }
      }
      this.closureScopes_.set(last.node, info);
      this.pendingClosureInfos_.push(info);
    }
    this.blockScopes_.pop();
  }

  private assignNestedLevels(): void {
    let pending = this.pendingClosureInfos_;
    if (pending.length == 0) return;
    let depths = new Array<i32>();
    for (let i = 0; i < pending.length; i++) {
      let d = pending[i].nestedLevel;
      if (depths.indexOf(d) < 0) depths.push(d);
    }
    depths.sort();
    let depthMap = new Map<i32, i32>();
    for (let i = 0; i < depths.length; i++) {
      depthMap.set(depths[i], i);
    }
    for (let i = 0; i < pending.length; i++) {
      pending[i].nestedLevel = depthMap.get(pending[i].nestedLevel);
    }
    this.pendingClosureInfos_ = new Array();
  }

  enterScope(): void {
    if (this.blockScopes_.length === 0) return;
    this.blockScopes_[this.blockScopes_.length - 1].pushScope();
  }

  leaveScope(): void {
    if (this.blockScopes_.length === 0) return;
    this.blockScopes_[this.blockScopes_.length - 1].popScope();
  }

  addVariableDeclaration(node: VariableDeclaration): void {
    if (this.blockScopes_.length === 0) return;
    this.blockScopes_[this.blockScopes_.length - 1].addVariableDeclaration(node);
  }

  addParameterDeclaration(node: ParameterNode): void {
    if (this.blockScopes_.length === 0) return;
    this.blockScopes_[this.blockScopes_.length - 1].addParameter(node);
  }

  checkAndMarkClosureVariable(name: string): bool {
    if (this.blockScopes_.length === 0) return false;
    const current = this.blockScopes_[this.blockScopes_.length - 1];
    if (current.findVariable(name) !== null) return false;

    if (this.blockScopes_.length < 2) return false;
    for (let i = this.blockScopes_.length - 2; i >= 0; i--) {
      const scope = this.blockScopes_[i];
      const variable = scope.findVariable(name);
      if (variable !== null) {
        let crossedFunction = false;
        for (let j = i + 1; j < this.blockScopes_.length; j++) {
          if (this.blockScopes_[j].isFunction) {
            crossedFunction = true;
            break;
          }
        }
        if (crossedFunction) {
          variable.markCaptured();
          let enclosingFunctionIndex = i;
          for (let j = i; j >= 0; j--) {
            if (this.blockScopes_[j].isFunction) {
              enclosingFunctionIndex = j;
              break;
            }
          }
          this.markRangeAsClosure(enclosingFunctionIndex);
        }
        return crossedFunction;
      }
    }
    return false;
  }

  checkAndMarkCapturedThis(): bool {
    if (this.blockScopes_.length === 0) return false;
    const current = this.blockScopes_[this.blockScopes_.length - 1];
    if (current.hasThis) return false;

    if (this.blockScopes_.length < 2) return false;
    for (let i = this.blockScopes_.length - 2; i >= 0; i--) {
      const scope = this.blockScopes_[i];
      if (scope.hasThis) {
        let crossedFunction = false;
        for (let j = i + 1; j < this.blockScopes_.length; j++) {
          if (this.blockScopes_[j].isFunction) {
            crossedFunction = true;
            break;
          }
        }
        if (crossedFunction) {
          scope.markCapturesThis();
          this.markRangeAsClosure(i);
        }
        return crossedFunction;
      }
    }
    return false;
  }

  private markRangeAsClosure(start: i32): void {
    for (let i = start; i < this.blockScopes_.length; i++) {
      this.blockScopes_[i].markAsClosure();
    }
  }
}

export class ClosureScanner extends BaseVisitor {
  private closureScopes_: Map<Node, ClosureFunctionInfo>;
  private blockScopeChain_: BlockScopeChain;

  get closureFunctions(): Map<Node, ClosureFunctionInfo> {
    return this.closureScopes_;
  }

  constructor() {
    super();
    const closureScopes = new Map<Node, ClosureFunctionInfo>();
    this.closureScopes_ = closureScopes;
    this.blockScopeChain_ = new BlockScopeChain(closureScopes);
  }

  getClosureFunctionInfo(node: Node): ClosureFunctionInfo | null {
    if (this.closureScopes_.has(node)) {
      return this.closureScopes_.get(node);
    } else {
      return null;
    }
  }

  getCapturedVariablesOfFunction(node: Node): Set<Node> | null {
    const info = this.getClosureFunctionInfo(node);
    return info ? info.closureVariables : null;
  }

  private visitNodeInScope(node: Node | null): void {
    if (!node) return;
    this.blockScopeChain_.enterScope();
    this.visitNode(node);
    this.blockScopeChain_.leaveScope();
  }

  visitFunctionDeclaration(node: FunctionDeclaration): void {
    this.blockScopeChain_.enterFunction(node);
    super.visitFunctionDeclaration(node);
    this.blockScopeChain_.leaveFunction();
  }

  visitMethodDeclaration(node: MethodDeclaration): void {
    this.blockScopeChain_.enterFunction(node);
    super.visitMethodDeclaration(node);
    this.blockScopeChain_.leaveFunction();
  }

  visitVariableDeclaration(node: VariableDeclaration): void {
    this.blockScopeChain_.addVariableDeclaration(node);
    super.visitVariableDeclaration(node);
  }

  visitParameterNode(node: ParameterNode): void {
    this.blockScopeChain_.addParameterDeclaration(node);
    this.visitNode(node.name);
    // Skip node.type: when the type is a FunctionTypeNode (e.g. `(value: Object) => void`),
    // visiting it would trigger visitParameterNode for its parameters, incorrectly
    // registering type-annotation parameter names as variable declarations in the scope.
    this.visitNode(node.initializer);
  }

  visitBlockStatement(node: BlockStatement): void {
    this.blockScopeChain_.enterScope();
    super.visitBlockStatement(node);
    this.blockScopeChain_.leaveScope();
  }

  visitIfStatement(node: IfStatement): void {
    this.visitNode(node.condition);
    this.visitNodeInScope(node.ifTrue);
    this.visitNodeInScope(node.ifFalse);
  }

  visitForStatement(node: ForStatement): void {
    this.blockScopeChain_.enterLoop(node);
    super.visitForStatement(node);
    this.blockScopeChain_.leaveLoop();
  }

  visitForOfStatement(node: ForOfStatement): void {
    this.blockScopeChain_.enterLoop(node);
    super.visitForOfStatement(node);
    this.blockScopeChain_.leaveLoop();
  }

  visitWhileStatement(node: WhileStatement): void {
    this.blockScopeChain_.enterLoop(node);
    super.visitWhileStatement(node);
    this.blockScopeChain_.leaveLoop();
  }

  visitDoStatement(node: DoStatement): void {
    this.blockScopeChain_.enterLoop(node);
    super.visitDoStatement(node);
    this.blockScopeChain_.leaveLoop();
  }

  visitSwitchCase(node: SwitchCase): void {
    this.blockScopeChain_.enterScope();
    super.visitSwitchCase(node);
    this.blockScopeChain_.leaveScope();
  }

  visitTypeDeclaration(node: TypeDeclaration): void {
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.type);
  }

  visitIdentifierExpression(node: IdentifierExpression): void {
    this.blockScopeChain_.checkAndMarkClosureVariable(node.text);
  }

  visitThisExpression(node: ThisExpression): void {
    this.blockScopeChain_.checkAndMarkCapturedThis();
  }
}
