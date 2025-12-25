import { DeclarationBase, DecoratorKind, findDecorator, LiteralKind, StringLiteralExpression } from "./ast";
import { CommonFlags, INNER_DELIMITER, INSTANCE_DELIMITER, PATH_DELIMITER, STATIC_DELIMITER } from "./common";
import { DiagnosticCode } from "./diagnosticMessages.generated";
import { DecoratorFlags, Element, ElementKind } from "./program";

/** Mangles the internal name of an element with the specified name that is a child of the given parent. */
export function mangleInternalName(name: string, parent: Element, isInstance: bool): string {
  switch (parent.kind) {
    case ElementKind.File: {
      return parent.internalName + PATH_DELIMITER + name;
    }
    case ElementKind.Function: {
      assert(!isInstance);
      return parent.internalName + INNER_DELIMITER + name;
    }
    case ElementKind.PropertyPrototype: // properties are just containers
    case ElementKind.Property: {
      //
      parent = parent.parent;
      // fall-through
    }
    default: {
      return (
        mangleInternalName(parent.name, parent.parent, parent.is(CommonFlags.Instance)) +
        (isInstance ? INSTANCE_DELIMITER : STATIC_DELIMITER) +
        name
      );
    }
  }
}

export class MangleImportName {
  constructor(
    public mangleImportName_moduleName: string,
    public mangleImportName_elementName: string
  ) {}
}

function mangleImportElementName(name: string, parent: Element, isInstance: bool): string {
  switch (parent.kind) {
    case ElementKind.File: {
      return name;
    }
    case ElementKind.PropertyPrototype: // properties are just containers
    case ElementKind.Property: {
      parent = parent.parent;
      // fall-through
    }
    default: {
      return (
        mangleImportElementName(parent.name, parent.parent, parent.is(CommonFlags.Instance)) +
        (isInstance ? INSTANCE_DELIMITER : STATIC_DELIMITER) +
        name
      );
    }
  }
}

export function mangleImportName(element: Element, declarationBase: DeclarationBase): MangleImportName {
  // by default, use the file name as the module name
  let mangleImportName_moduleName = declarationBase.nameRange.source.simplePath;
  // and the internal name of the element within that file as the element name
  let mangleImportName_elementName = mangleImportElementName(
    element.name,
    element.parent,
    element.is(CommonFlags.Instance)
  );
  // override module name if a `module` statement is present
  let overriddenModuleName = declarationBase.overriddenModuleName;
  if (overriddenModuleName) mangleImportName_moduleName = overriddenModuleName;

  if (!element.hasDecorator(DecoratorFlags.External))
    return new MangleImportName(mangleImportName_moduleName, mangleImportName_elementName);

  let program = element.program;
  let decorator = assert(findDecorator(DecoratorKind.External, declarationBase.decorators));
  let args = decorator.args;
  if (args && args.length > 0) {
    let arg = args[0];
    // if one argument is given, override just the element name
    // if two arguments are given, override both module and element name
    if (arg.isLiteralKind(LiteralKind.String)) {
      mangleImportName_elementName = (<StringLiteralExpression>arg).value;
      if (args.length >= 2) {
        arg = args[1];
        if (arg.isLiteralKind(LiteralKind.String)) {
          mangleImportName_moduleName = mangleImportName_elementName;
          mangleImportName_elementName = (<StringLiteralExpression>arg).value;
          if (args.length > 2) {
            program.error(DiagnosticCode.Expected_0_arguments_but_got_1, decorator.range, "2", args.length.toString());
          }
        } else {
          program.error(DiagnosticCode.String_literal_expected, arg.range);
        }
      }
    } else {
      program.error(DiagnosticCode.String_literal_expected, arg.range);
    }
  } else {
    program.error(DiagnosticCode.Expected_at_least_0_arguments_but_got_1, decorator.range, "1", "0");
  }
  return new MangleImportName(mangleImportName_moduleName, mangleImportName_elementName);
}
