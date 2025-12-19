import * as utf8 from "warpo/utf8/const_str";

let s: utf8.ConstStr = utf8.build("abcdef");

assert(s.size == 6);

assert(s.toString() == "abcdef");
