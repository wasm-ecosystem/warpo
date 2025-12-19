import { utf8 } from "utf8_const_str";

let s = utf8.build("abcdef");

assert(s.size == 6);

assert(s.toString() == "abcdef");
