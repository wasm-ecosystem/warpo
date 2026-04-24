import { BaseVisitor } from "./visitor";
import {
  BlockStatement,
  DoStatement,
  ForOfStatement,
  ForStatement,
  FunctionDeclaration,
  IdentifierExpression,
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

export class ClosureFunctionInfo {
  closureVariables: Set<Node> = new Set();
  forInitClosureVariables: Set<VariableDeclaration> = new Set();
  capturesThis: bool = false;
  nestedLevel: i32 = 0;
}

const enum ScopeNodeKind {
  Function,
  Loop,
  Block,
}

class ScopeTreeNode {
  children: ScopeTreeNode[] = [];
  // All variables and parameters declared in this scope.
  locals: Map<string, Node> = new Map();
  // Variables from this scope that are captured by an inner function.
  // Populated on Function/Loop scopes only (Block captures are promoted to the nearest ancestor).
  capturedLocals: Map<string, Node> = new Map();
  // Subset of capturedLocals that are for-loop initializer declarations (e.g. `let i` in `for (let i = ...)`).
  forInitClosureLocals: Set<VariableDeclaration> = new Set();
  info: ClosureFunctionInfo | null = null;
  kind: ScopeNodeKind;
  astNode: Node;
  belongingFunction: ScopeTreeNode | null;
  isClosure: bool = false;
  nestedLevel: i32 = -1;
  constructor(
    public parent: ScopeTreeNode | null,
    kind: ScopeNodeKind,
    astNode: Node
  ) {
    this.kind = kind;
    this.astNode = astNode;
    if (kind == ScopeNodeKind.Function) {
      this.belongingFunction = null;
    } else {
      this.belongingFunction =
        assert(parent).kind == ScopeNodeKind.Function ? parent : assert(parent).belongingFunction;
    }
    if (parent) parent.children.push(this);
  }

  addLocal(name: string, node: Node): void {
    this.locals.set(name, node);
  }

  addParameter(name: string, node: Node): void {
    assert(this.kind == ScopeNodeKind.Function);
    this.locals.set(name, node);
  }

  findDeclaration(name: string): ScopeTreeNode | null {
    let cur: ScopeTreeNode | null = this;
    while (cur) {
      if (cur.locals.has(name)) return cur;
      cur = cur.parent;
    }
    return null;
  }
}

export class ClosureScanner extends BaseVisitor {
  private closureScopes_: Map<Node, ClosureFunctionInfo> = new Map();
  private currentTreeNode_: ScopeTreeNode | null = null;

  get closureFunctions(): Map<Node, ClosureFunctionInfo> {
    return this.closureScopes_;
  }

  constructor() {
    super();
  }

  getClosureFunctionInfo(node: Node): ClosureFunctionInfo | null {
    if (this.closureScopes_.has(node)) return this.closureScopes_.get(node);
    return null;
  }

  getCapturedVariablesOfFunction(node: Node): Set<Node> | null {
    const info = this.getClosureFunctionInfo(node);
    return info ? info.closureVariables : null;
  }

  private enterTreeNode(kind: ScopeNodeKind, astNode: Node): void {
    this.currentTreeNode_ = new ScopeTreeNode(this.currentTreeNode_, kind, astNode);
  }

  private leaveTreeNode(): void {
    let node = assert(this.currentTreeNode_);
    this.currentTreeNode_ = node.parent;
    if (!node.parent) this.assignNestedLevels(node);
  }

  private assignNestedLevels(root: ScopeTreeNode): void {
    root.nestedLevel = root.isClosure ? 0 : -1;
    let stack: ScopeTreeNode[] = [];
    for (let i = root.children.length - 1; i >= 0; i--) {
      stack.push(root.children[i]);
    }
    while (stack.length > 0) {
      let node = stack.pop();
      let parentLevel = assert(node.parent).nestedLevel;
      if (node.kind == ScopeNodeKind.Function) {
        if (parentLevel != -1 || node.isClosure) {
          // parentLevel != -1 means there must be a closure function in parent chain
          // by design, if a function is within a closure function, it is also a closure function, even if it doesn't capture any variable itself.
          node.nestedLevel = parentLevel + 1;
        } else {
          node.nestedLevel = -1;
        }
      } else {
        node.nestedLevel = node.isClosure ? parentLevel + 1 : parentLevel;
      }
      for (let i = node.children.length - 1; i >= 0; i--) {
        stack.push(node.children[i]);
      }
    }
    this.buildClosureInfos(root);
  }

  private buildClosureInfos(root: ScopeTreeNode): void {
    let stack: ScopeTreeNode[] = [root];
    while (stack.length > 0) {
      let node = stack.pop();
      if (node.isClosure) {
        assert(node.kind != ScopeNodeKind.Block);
        let info = new ClosureFunctionInfo();
        info.nestedLevel = node.nestedLevel;
        let keys = node.capturedLocals.keys();
        let values = node.capturedLocals.values();
        for (let j = 0; j < keys.length; j++) {
          let name = keys[j];
          if (name == "this") {
            info.capturesThis = true;
          } else {
            info.closureVariables.add(values[j]);
          }
        }
        info.forInitClosureVariables = node.forInitClosureLocals;
        node.info = info;
        this.closureScopes_.set(node.astNode, info);
      }
      for (let i = node.children.length - 1; i >= 0; i--) {
        stack.push(node.children[i]);
      }
    }
  }

  visitFunctionDeclaration(node: FunctionDeclaration): void {
    this.enterTreeNode(ScopeNodeKind.Function, node);
    super.visitFunctionDeclaration(node);
    this.leaveTreeNode();
  }

  visitMethodDeclaration(node: MethodDeclaration): void {
    this.enterTreeNode(ScopeNodeKind.Function, node);
    assert(this.currentTreeNode_).addLocal("this", node);
    super.visitMethodDeclaration(node);
    this.leaveTreeNode();
  }

  visitBlockStatement(node: BlockStatement): void {
    if (!this.currentTreeNode_) return;
    this.enterTreeNode(ScopeNodeKind.Block, node);
    super.visitBlockStatement(node);
    this.leaveTreeNode();
  }

  visitForStatement(node: ForStatement): void {
    if (!this.currentTreeNode_) return;
    this.enterTreeNode(ScopeNodeKind.Loop, node);
    super.visitForStatement(node);
    let treeNode = assert(this.currentTreeNode_);
    let initializer = node.initializer;
    if (initializer && initializer.kind == NodeKind.Variable) {
      let decls = (<VariableStatement>initializer).declarations;
      for (let d = 0; d < decls.length; d++) {
        if (treeNode.capturedLocals.has(decls[d].name.text)) treeNode.forInitClosureLocals.add(decls[d]);
      }
    }
    this.leaveTreeNode();
  }

  visitForOfStatement(node: ForOfStatement): void {
    if (!this.currentTreeNode_) return;
    this.enterTreeNode(ScopeNodeKind.Loop, node);
    super.visitForOfStatement(node);
    this.leaveTreeNode();
  }

  visitWhileStatement(node: WhileStatement): void {
    if (!this.currentTreeNode_) return;
    this.enterTreeNode(ScopeNodeKind.Loop, node);
    super.visitWhileStatement(node);
    this.leaveTreeNode();
  }

  visitDoStatement(node: DoStatement): void {
    if (!this.currentTreeNode_) return;
    this.enterTreeNode(ScopeNodeKind.Loop, node);
    super.visitDoStatement(node);
    this.leaveTreeNode();
  }

  visitSwitchCase(node: SwitchCase): void {
    if (!this.currentTreeNode_) return;
    this.enterTreeNode(ScopeNodeKind.Block, node);
    super.visitSwitchCase(node);
    this.leaveTreeNode();
  }

  visitVariableDeclaration(node: VariableDeclaration): void {
    if (this.currentTreeNode_) this.currentTreeNode_!.addLocal(node.name.text, node);
    super.visitVariableDeclaration(node);
  }

  visitTypeDeclaration(node: TypeDeclaration): void {
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.type);
  }

  visitParameterNode(node: ParameterNode): void {
    if (!this.currentTreeNode_ || this.currentTreeNode_!.kind != ScopeNodeKind.Function) return;
    this.currentTreeNode_!.addParameter(node.name.text, node);
    this.visitNode(node.name);
    this.visitNode(node.initializer);
  }

  private checkCapture(name: string): void {
    if (!this.currentTreeNode_) return;
    let current = assert(this.currentTreeNode_);
    const declaredScope = current.findDeclaration(name);
    if (!declaredScope) return;
    const currentFunction = current.kind == ScopeNodeKind.Function ? current : assert(current.belongingFunction);
    const declaredFunction =
      declaredScope.kind == ScopeNodeKind.Function ? declaredScope : declaredScope.belongingFunction;
    if (currentFunction === declaredFunction) return;
    currentFunction.isClosure = true;
    let owningScope: ScopeTreeNode = declaredScope;
    if (declaredScope.kind == ScopeNodeKind.Block) {
      let walk: ScopeTreeNode | null = declaredScope.parent;
      while (walk && walk.kind == ScopeNodeKind.Block) walk = walk.parent;
      owningScope = assert(walk);
    }
    owningScope.isClosure = true;
    owningScope.capturedLocals.set(name, assert(declaredScope.locals.get(name)));
    assert(declaredFunction).isClosure = true;
    let cur: ScopeTreeNode | null = currentFunction.parent;
    while (cur && cur !== owningScope) {
      if (cur.kind == ScopeNodeKind.Function) cur.isClosure = true;
      cur = cur.parent;
    }
  }

  visitIdentifierExpression(node: IdentifierExpression): void {
    this.checkCapture(node.text);
  }

  visitThisExpression(node: ThisExpression): void {
    this.checkCapture("this");
  }
}
