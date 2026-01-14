// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DeclarationBase, DecoratorKind, findDecorator, LiteralKind, StringLiteralExpression } from "./ast";
import { CommonFlags } from "./common";
import { DiagnosticCode } from "./diagnosticMessages.generated";
import { Type } from "./types";
import { DecoratorFlags, Element, ElementKind } from "./program";

// =========================== Import Name Mangling ===========================

/** Represents a mangled import name consisting of a module name and an element name. */
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

/** Path delimiter inserted between file system levels. */
export const PATH_DELIMITER = "/";
/** Delimiter used between class and namespace names and static members. */
export const STATIC_DELIMITER = ".";
/** Library directory prefix. */
export const LIBRARY_PREFIX = "~lib" + PATH_DELIMITER;
/** Path index suffix. */
export const INDEX_SUFFIX = PATH_DELIMITER + "index";
/** Delimiter used between class names and instance members. */
const INSTANCE_DELIMITER = "#";
/** Function name prefix used for getters. */
const GETTER_PREFIX = "get:";
/** Function name prefix used for setters. */
const SETTER_PREFIX = "set:";
/** Delimiter used between a function and its inner elements. */
const INNER_DELIMITER = "~";
/** Stub function delimiter. */
const STUB_DELIMITER = "@";

// ===========================  Name Mangling ===========================
/**
 * EBNF for mangled internal names:
 * There is some left recursion present in this grammar. For readability, we have not eliminated it.
 *
 * internal_name                    ::=   file_internal_name '/' name
 *                                      | internal_name '~' name
 *                                      | internal_name ('#' | '.') name
 *                                      ;
 * file_internal_name               ::= [ '~lib/' ] file_name { '/' file_name };
 *
 * name                             ::=   identifier
 *                                      | generic_instance_name
 *                                      | stub_name
 *                                      | getter_name
 *                                      | setter_name
 *                                      | computed_property_name
 *                                      ;
 * generic_instance_name            ::= name [ generic_instance_key ];
 * generic_instance_key             ::= '<' internal_name { ',' internal_name } '>';
 * stub_name                        ::= name '@' identifier;
 * getter_name                      ::= 'get:' name;
 * setter_name                      ::= 'set:' name;
 * computed_property_name           ::= '[' internal_name ']';
 *
 * identifier                       ::= ? see parser ?;
 * file_name                        ::= ? os allowed file name ?;
 */

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

/** Mangles a getter name with the specified property name. */
export function mangleGetterName(propertyName: string): string {
  return GETTER_PREFIX + propertyName;
}

/** Mangles a setter name with the specified property name. */
export function mangleSetterName(propertyName: string): string {
  return SETTER_PREFIX + propertyName;
}

export function mangleComputedPropertyName(innerElement: Element): string {
  return `[${innerElement.internalName}]`;
}

export function mangleStubName(baseName: string, stubIdentifier: string): string {
  return baseName + STUB_DELIMITER + stubIdentifier;
}

/** Converts an array of types to its combined string representation. */
export function mangleGenericInstanceKey(types: Type[] | null): string {
  if (types == null) return "";
  let numTypes = types.length;
  if (!numTypes) return "";
  let sb = new Array<string>(numTypes);
  for (let i = 0; i < numTypes; ++i) {
    unchecked((sb[i] = types[i].toString(true)));
  }
  return sb.join(",");
}

export function mangleGenericInstanceName(name: string, instanceKey: string): string {
  if (instanceKey.length == 0) return name;
  return `${name}<${instanceKey}>`;
}
