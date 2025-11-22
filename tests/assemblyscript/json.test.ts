import { describe, expect, test } from "assemblyscript-unittest-framework/assembly/index";
import { DiagnosticMessage } from "../../assemblyscript/src/diagnostics";
import {
  JsonArray,
  JsonBool,
  JsonF64,
  JsonI64,
  JsonObject,
  JsonParser,
  JsonString,
  JsonUnknown,
  JsonValueKind,
} from "../../assemblyscript/src/json";
import { JsonSource, SourceKind } from "../../assemblyscript/src/ast";

class JsonTestHelper {
  obj: JsonObject | null;
  diag: string | null;
  constructor(text: string) {
    let source = new JsonSource(SourceKind.User, "test.json", text);
    let diag: DiagnosticMessage[] = [];
    let parser = new JsonParser(source, diag);
    let obj = parser.parse();
    this.obj = obj;
    this.diag = diag.length > 0 ? diag[0].message : null;
  }
}

describe("json parser", () => {
  test("JSON object", () => {
    let ret = new JsonTestHelper(`{ "name": "test" }`);

    expect(ret.obj).notNull();
    expect(ret.obj!.keys[0]).equal("name");
    expect((ret.obj!.values[0] as JsonString).value).equal("test");
  });

  test("JSON empty object", () => {
    let ret = new JsonTestHelper(`{}`);

    expect(ret.obj).notNull();
    expect(ret.obj!.keys.length).equal(0);
    expect(ret.obj!.values.length).equal(0);
  });

  test("JSON array", () => {
    let ret = new JsonTestHelper(`{ "v": [1, 2, 3]}`);

    expect(ret.obj).notNull();
    expect(ret.obj!.keys[0]).equal("v");
    expect((ret.obj!.values[0] as JsonArray).uniqueType).equal(JsonValueKind.I64);
  });

  test("multiple fields", () => {
    let ret = new JsonTestHelper(`{ "K0": "V0", "K1": "V1", "K2": "V2" }`);

    expect(ret.obj).notNull();
    expect(ret.obj!.keys[0]).equal("K0");
    expect(ret.obj!.keys[1]).equal("K1");
    expect(ret.obj!.keys[2]).equal("K2");
    expect((ret.obj!.values[0] as JsonString).value).equal("V0");
    expect((ret.obj!.values[1] as JsonString).value).equal("V1");
    expect((ret.obj!.values[2] as JsonString).value).equal("V2");
  });

  test("multiple type", () => {
    let ret = new JsonTestHelper(
      `
      {
        "K0": [],
        "K1": 100,
        "K2": 100.2,
        "K3": true,
        "K4": null,
        "K5": {
          "key": "value"
        }
      }
      `
    );

    expect(ret.obj).notNull();
    expect(ret.obj!.keys[0]).equal("K0");
    expect(ret.obj!.values[0] instanceof JsonArray).equal(true);

    expect(ret.obj!.keys[1]).equal("K1");
    expect((ret.obj!.values[1] as JsonI64).value).equal(100);

    expect(ret.obj!.keys[2]).equal("K2");
    expect((ret.obj!.values[2] as JsonF64).value).equal(100.2);

    expect(ret.obj!.keys[3]).equal("K3");
    expect((ret.obj!.values[3] as JsonBool).value).equal(true);

    expect(ret.obj!.keys[4]).equal("K4");
    expect(ret.obj!.values[4] instanceof JsonUnknown).equal(true);

    expect(ret.obj!.keys[5]).equal("K5");
    expect((ret.obj!.values[5] as JsonObject).keys[0]).equal("key");
    expect(((ret.obj!.values[5] as JsonObject).values[0] as JsonString).value).equal("value");
  });

  test("range", () => {
    const text = `
{
  "K0": [],
  "K1": 100,
  "K2": 100.2,
  "K3": true,
  "K4": null,
  "K5": {
    "key": "value"
  }
}
      `;
    let ret = new JsonTestHelper(text);
    expect(ret.obj!.range.toString()).equal(text.trim());
    expect(ret.obj!.values[0].range.toString()).equal("[]");
    expect(ret.obj!.values[1].range.toString()).equal("100");
    expect(ret.obj!.values[2].range.toString()).equal("100.2");
    expect(ret.obj!.values[3].range.toString()).equal("true");
    expect(ret.obj!.values[4].range.toString()).equal("null");
    expect(ret.obj!.values[5].range.toString()).equal(`{
    "key": "value"
  }`);
    expect((ret.obj!.values[5] as JsonObject).values[0].range.toString()).equal(`"value"`);
  });

  test("EOF", () => {
    let ret = new JsonTestHelper(`{ "name": "test" } 1`);

    expect(ret.obj).isNull();
    expect(ret.diag).equal("'EOF' expected.");
  });

  describe("top level", () => {
    test("number", () => {
      let ret = new JsonTestHelper(`1`);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("Not implemented: top level scalar value");
    });
    test("array", () => {
      let ret = new JsonTestHelper(`1`);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("Not implemented: top level scalar value");
    });
    test("array", () => {
      let ret = new JsonTestHelper(`[1, {}, []]`);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("Not implemented: top level scalar value");
    });
    test("null", () => {
      let ret = new JsonTestHelper(`null`);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("Not implemented: top level scalar value");
    });
    test("boolean", () => {
      let ret = new JsonTestHelper(`true`);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("Not implemented: top level scalar value");
    });
  });

  describe("broken", () => {
    test("miss close brace", () => {
      let ret = new JsonTestHelper(`{ "name": "test" `);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("'}' expected.");
    });
    test("addition open brace", () => {
      let ret = new JsonTestHelper(`{{ "name": "test" `);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("'json key' expected.");
    });
    test("addition comma", () => {
      let ret = new JsonTestHelper(`{ "name": "test", } `);

      expect(ret.obj).isNull();
      expect(ret.diag).equal("'json key' expected.");
    });
  });
});
