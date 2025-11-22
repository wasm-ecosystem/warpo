import { version, name, major, minor, integer_array, float_array, string_array } from "./import-from-json.json";

assert(name === "import-from-json");
assert(version === "1.2.4");
assert(major === 1);
assert(minor === 2);

assert(integer_array.length === 3);
assert(integer_array[0] === 1);
assert(integer_array[1] === 2);
assert(integer_array[2] === 3);

assert(float_array.length === 3);
assert(float_array[0] === 1.0);
assert(float_array[1] === 2.0);
assert(float_array[2] === 3.0);

assert(string_array.length === 3);
assert(string_array[0] === "one");
assert(string_array[1] === "two");
assert(string_array[2] === "three");
