import {
  ArrayLiteralExpression,
  AssertionExpression,
  BinaryExpression,
  BlockStatement,
  BreakStatement,
  CallExpression,
  ClassDeclaration,
  ClassExpression,
  CommentNode,
  CommaExpression,
  CompiledExpression,
  ComputedPropertyName,
  ConstructorExpression,
  ContinueStatement,
  DecoratorNode,
  DoStatement,
  ElementAccessExpression,
  EmptyStatement,
  EnumDeclaration,
  EnumValueDeclaration,
  ExportDefaultStatement,
  ExportImportStatement,
  ExportMember,
  ExportStatement,
  ExpressionStatement,
  FalseExpression,
  FieldDeclaration,
  FloatLiteralExpression,
  ForOfStatement,
  ForStatement,
  FunctionDeclaration,
  FunctionExpression,
  FunctionTypeNode,
  IdentifierExpression,
  IfStatement,
  ImportDeclaration,
  ImportStatement,
  IndexSignatureNode,
  InstanceOfExpression,
  IntegerLiteralExpression,
  InterfaceDeclaration,
  JsonSource,
  MethodDeclaration,
  ModuleDeclaration,
  NamedTypeNode,
  NamespaceDeclaration,
  NewExpression,
  NullExpression,
  Node,
  ObjectLiteralExpression,
  OmittedExpression,
  ParameterNode,
  ParenthesizedExpression,
  PropertyAccessExpression,
  RegexpLiteralExpression,
  ReturnStatement,
  Source,
  StringLiteralExpression,
  SuperExpression,
  SwitchCase,
  SwitchStatement,
  TemplateLiteralExpression,
  TernaryExpression,
  ThisExpression,
  ThrowStatement,
  TrueExpression,
  TryStatement,
  TupleTypeNode,
  TypeDeclaration,
  TypeName,
  TypeParameterNode,
  UnaryPostfixExpression,
  UnaryPrefixExpression,
  VariableDeclaration,
  VariableStatement,
  VoidStatement,
  WhileStatement,
  INode,
} from "../ast";

export interface IVisitor {
  visitComputedPropertyName(node: ComputedPropertyName): void;
  visitTypeName(node: TypeName): void;
  visitNamedTypeNode(node: NamedTypeNode): void;
  visitFunctionTypeNode(node: FunctionTypeNode): void;
  visitTupleTypeNode(node: TupleTypeNode): void;
  visitTypeParameterNode(node: TypeParameterNode): void;
  visitParameterNode(node: ParameterNode): void;
  visitDecoratorNode(node: DecoratorNode): void;
  visitCommentNode(node: CommentNode): void;
  visitIdentifierExpression(node: IdentifierExpression): void;
  visitArrayLiteralExpression(node: ArrayLiteralExpression): void;
  visitAssertionExpression(node: AssertionExpression): void;
  visitBinaryExpression(node: BinaryExpression): void;
  visitCallExpression(node: CallExpression): void;
  visitClassExpression(node: ClassExpression): void;
  visitCommaExpression(node: CommaExpression): void;
  visitConstructorExpression(node: ConstructorExpression): void;
  visitElementAccessExpression(node: ElementAccessExpression): void;
  visitFloatLiteralExpression(node: FloatLiteralExpression): void;
  visitFunctionExpression(node: FunctionExpression): void;
  visitInstanceOfExpression(node: InstanceOfExpression): void;
  visitIntegerLiteralExpression(node: IntegerLiteralExpression): void;
  visitNewExpression(node: NewExpression): void;
  visitNullExpression(node: NullExpression): void;
  visitObjectLiteralExpression(node: ObjectLiteralExpression): void;
  visitOmittedExpression(node: OmittedExpression): void;
  visitParenthesizedExpression(node: ParenthesizedExpression): void;
  visitPropertyAccessExpression(node: PropertyAccessExpression): void;
  visitRegexpLiteralExpression(node: RegexpLiteralExpression): void;
  visitTernaryExpression(node: TernaryExpression): void;
  visitStringLiteralExpression(node: StringLiteralExpression): void;
  visitSuperExpression(node: SuperExpression): void;
  visitTemplateLiteralExpression(node: TemplateLiteralExpression): void;
  visitThisExpression(node: ThisExpression): void;
  visitTrueExpression(node: TrueExpression): void;
  visitFalseExpression(node: FalseExpression): void;
  visitUnaryPostfixExpression(node: UnaryPostfixExpression): void;
  visitUnaryPrefixExpression(node: UnaryPrefixExpression): void;
  visitCompiledExpression(node: CompiledExpression): void;
  visitSource(node: Source): void;
  visitJsonSource(node: JsonSource): void;
  visitIndexSignatureNode(node: IndexSignatureNode): void;
  visitBlockStatement(node: BlockStatement): void;
  visitBreakStatement(node: BreakStatement): void;
  visitClassDeclaration(node: ClassDeclaration): void;
  visitContinueStatement(node: ContinueStatement): void;
  visitDoStatement(node: DoStatement): void;
  visitEmptyStatement(node: EmptyStatement): void;
  visitEnumDeclaration(node: EnumDeclaration): void;
  visitEnumValueDeclaration(node: EnumValueDeclaration): void;
  visitExportImportStatement(node: ExportImportStatement): void;
  visitExportMember(node: ExportMember): void;
  visitExportStatement(node: ExportStatement): void;
  visitExportDefaultStatement(node: ExportDefaultStatement): void;
  visitExpressionStatement(node: ExpressionStatement): void;
  visitFieldDeclaration(node: FieldDeclaration): void;
  visitForStatement(node: ForStatement): void;
  visitForOfStatement(node: ForOfStatement): void;
  visitFunctionDeclaration(node: FunctionDeclaration): void;
  visitMethodDeclaration(node: MethodDeclaration): void;
  visitIfStatement(node: IfStatement): void;
  visitImportDeclaration(node: ImportDeclaration): void;
  visitImportStatement(node: ImportStatement): void;
  visitInterfaceDeclaration(node: InterfaceDeclaration): void;
  visitNamespaceDeclaration(node: NamespaceDeclaration): void;
  visitReturnStatement(node: ReturnStatement): void;
  visitSwitchCase(node: SwitchCase): void;
  visitSwitchStatement(node: SwitchStatement): void;
  visitThrowStatement(node: ThrowStatement): void;
  visitTryStatement(node: TryStatement): void;
  visitModuleDeclaration(node: ModuleDeclaration): void;
  visitTypeDeclaration(node: TypeDeclaration): void;
  visitVariableDeclaration(node: VariableDeclaration): void;
  visitVariableStatement(node: VariableStatement): void;
  visitVoidStatement(node: VoidStatement): void;
  visitWhileStatement(node: WhileStatement): void;
}

export class BaseVisitor implements IVisitor {
  protected visitNode(node: INode | null): void {
    if (node) node.accept(this);
  }

  protected visitNodes<T extends INode>(nodes: T[] | null): void {
    if (!nodes) return;
    for (let i = 0, k = nodes.length; i < k; ++i) nodes[i].accept(this);
  }

  visitComputedPropertyName(node: ComputedPropertyName): void {
    this.visitNode(node.expression);
  }

  visitTypeName(node: TypeName): void {
    this.visitNode(node.identifier);
    this.visitNode(node.next);
  }

  visitNamedTypeNode(node: NamedTypeNode): void {
    this.visitNode(node.name);
    this.visitNodes(node.typeArguments);
  }

  visitFunctionTypeNode(node: FunctionTypeNode): void {
    this.visitNodes(node.parameters);
    this.visitNode(node.returnType);
    this.visitNode(node.explicitThisType);
  }

  visitTupleTypeNode(node: TupleTypeNode): void {
    this.visitNodes(node.elementTypes);
  }

  visitTypeParameterNode(node: TypeParameterNode): void {
    this.visitNode(node.name);
    this.visitNode(node.extendsType);
    this.visitNode(node.defaultType);
  }

  visitParameterNode(node: ParameterNode): void {
    this.visitNode(node.name);
    this.visitNode(node.type);
    this.visitNode(node.initializer);
  }

  visitDecoratorNode(node: DecoratorNode): void {
    this.visitNode(node.name);
    this.visitNodes(node.args);
  }

  visitCommentNode(node: CommentNode): void {}

  visitIdentifierExpression(node: IdentifierExpression): void {}

  visitArrayLiteralExpression(node: ArrayLiteralExpression): void {
    this.visitNodes(node.elementExpressions);
  }

  visitAssertionExpression(node: AssertionExpression): void {
    this.visitNode(node.expression);
    this.visitNode(node.toType);
  }

  visitBinaryExpression(node: BinaryExpression): void {
    this.visitNode(node.left);
    this.visitNode(node.right);
  }

  visitCallExpression(node: CallExpression): void {
    this.visitNode(node.expression);
    this.visitNodes(node.typeArguments);
    this.visitNodes(node.args);
  }

  visitClassExpression(node: ClassExpression): void {
    this.visitNode(node.declaration);
  }

  visitCommaExpression(node: CommaExpression): void {
    this.visitNodes(node.expressions);
  }

  visitConstructorExpression(node: ConstructorExpression): void {}

  visitElementAccessExpression(node: ElementAccessExpression): void {
    this.visitNode(node.expression);
    this.visitNode(node.elementExpression);
  }

  visitFloatLiteralExpression(node: FloatLiteralExpression): void {}

  visitFunctionExpression(node: FunctionExpression): void {
    this.visitNode(node.declaration);
  }

  visitInstanceOfExpression(node: InstanceOfExpression): void {
    this.visitNode(node.expression);
    this.visitNode(node.isType);
  }

  visitIntegerLiteralExpression(node: IntegerLiteralExpression): void {}

  visitNewExpression(node: NewExpression): void {
    this.visitNode(node.typeName);
    this.visitNodes(node.typeArguments);
    this.visitNodes(node.args);
  }

  visitNullExpression(node: NullExpression): void {}

  visitObjectLiteralExpression(node: ObjectLiteralExpression): void {
    this.visitNodes(node.names);
    this.visitNodes(node.values);
  }

  visitOmittedExpression(node: OmittedExpression): void {}

  visitParenthesizedExpression(node: ParenthesizedExpression): void {
    this.visitNode(node.expression);
  }

  visitPropertyAccessExpression(node: PropertyAccessExpression): void {
    this.visitNode(node.expression);
    this.visitNode(node.property);
  }

  visitRegexpLiteralExpression(node: RegexpLiteralExpression): void {}

  visitTernaryExpression(node: TernaryExpression): void {
    this.visitNode(node.condition);
    this.visitNode(node.ifThen);
    this.visitNode(node.ifElse);
  }

  visitStringLiteralExpression(node: StringLiteralExpression): void {}

  visitSuperExpression(node: SuperExpression): void {}

  visitTemplateLiteralExpression(node: TemplateLiteralExpression): void {
    this.visitNode(node.tag);
    this.visitNodes(node.expressions);
  }

  visitThisExpression(node: ThisExpression): void {}

  visitTrueExpression(node: TrueExpression): void {}

  visitFalseExpression(node: FalseExpression): void {}

  visitUnaryPostfixExpression(node: UnaryPostfixExpression): void {
    this.visitNode(node.operand);
  }

  visitUnaryPrefixExpression(node: UnaryPrefixExpression): void {
    this.visitNode(node.operand);
  }

  visitCompiledExpression(node: CompiledExpression): void {}

  visitSource(node: Source): void {
    this.visitNodes(node.statements);
  }

  visitJsonSource(node: JsonSource): void {
    this.visitNodes(node.statements);
  }

  visitIndexSignatureNode(node: IndexSignatureNode): void {
    this.visitNode(node.keyType);
    this.visitNode(node.valueType);
  }

  visitBlockStatement(node: BlockStatement): void {
    this.visitNodes(node.statements);
  }

  visitBreakStatement(node: BreakStatement): void {
    this.visitNode(node.label);
  }

  visitClassDeclaration(node: ClassDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.extendsType);
    this.visitNodes(node.implementsTypes);
    this.visitNode(node.indexSignature);
    this.visitNodes(node.members);
  }

  visitContinueStatement(node: ContinueStatement): void {
    this.visitNode(node.label);
  }

  visitDoStatement(node: DoStatement): void {
    this.visitNode(node.body);
    this.visitNode(node.condition);
  }

  visitEmptyStatement(node: EmptyStatement): void {}

  visitEnumDeclaration(node: EnumDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNodes(node.values);
  }

  visitEnumValueDeclaration(node: EnumValueDeclaration): void {
    this.visitNode(node.name);
    this.visitNode(node.initializer);
  }

  visitExportImportStatement(node: ExportImportStatement): void {
    this.visitNode(node.name);
    this.visitNode(node.externalName);
  }

  visitExportMember(node: ExportMember): void {
    this.visitNode(node.localName);
    this.visitNode(node.exportedName);
  }

  visitExportStatement(node: ExportStatement): void {
    this.visitNodes(node.members);
    this.visitNode(node.path);
  }

  visitExportDefaultStatement(node: ExportDefaultStatement): void {
    this.visitNode(node.declaration);
  }

  visitExpressionStatement(node: ExpressionStatement): void {
    this.visitNode(node.expression);
  }

  visitFieldDeclaration(node: FieldDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNode(node.type);
    this.visitNode(node.initializer);
  }

  visitForStatement(node: ForStatement): void {
    this.visitNode(node.initializer);
    this.visitNode(node.condition);
    this.visitNode(node.incrementor);
    this.visitNode(node.body);
  }

  visitForOfStatement(node: ForOfStatement): void {
    this.visitNode(node.variable);
    this.visitNode(node.iterable);
    this.visitNode(node.body);
  }

  visitFunctionDeclaration(node: FunctionDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.signature);
    this.visitNode(node.body);
  }

  visitMethodDeclaration(node: MethodDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.signature);
    this.visitNode(node.body);
  }

  visitIfStatement(node: IfStatement): void {
    this.visitNode(node.condition);
    this.visitNode(node.ifTrue);
    this.visitNode(node.ifFalse);
  }

  visitImportDeclaration(node: ImportDeclaration): void {
    this.visitNode(node.name);
    this.visitNode(node.foreignName);
  }

  visitImportStatement(node: ImportStatement): void {
    this.visitNodes(node.declarations);
    this.visitNode(node.namespaceName);
    this.visitNode(node.path);
  }

  visitInterfaceDeclaration(node: InterfaceDeclaration): void {
    this.visitClassDeclaration(node);
  }

  visitNamespaceDeclaration(node: NamespaceDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNodes(node.members);
  }

  visitReturnStatement(node: ReturnStatement): void {
    this.visitNode(node.value);
  }

  visitSwitchCase(node: SwitchCase): void {
    this.visitNode(node.label);
    this.visitNodes(node.statements);
  }

  visitSwitchStatement(node: SwitchStatement): void {
    this.visitNode(node.condition);
    this.visitNodes(node.cases);
  }

  visitThrowStatement(node: ThrowStatement): void {
    this.visitNode(node.value);
  }

  visitTryStatement(node: TryStatement): void {
    this.visitNodes(node.bodyStatements);
    this.visitNode(node.catchVariable);
    this.visitNodes(node.catchStatements);
    this.visitNodes(node.finallyStatements);
  }

  visitModuleDeclaration(node: ModuleDeclaration): void {}

  visitTypeDeclaration(node: TypeDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNodes(node.typeParameters);
    this.visitNode(node.type);
  }

  visitVariableDeclaration(node: VariableDeclaration): void {
    this.visitNode(node.name);
    this.visitNodes(node.decorators);
    this.visitNode(node.type);
    this.visitNode(node.initializer);
  }

  visitVariableStatement(node: VariableStatement): void {
    this.visitNodes(node.decorators);
    this.visitNodes(node.declarations);
  }

  visitVoidStatement(node: VoidStatement): void {
    this.visitNode(node.expression);
  }

  visitWhileStatement(node: WhileStatement): void {
    this.visitNode(node.condition);
    this.visitNode(node.body);
  }
}
