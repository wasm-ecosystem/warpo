import { v } from "@as/custom/lib/index";

export function _start(): void {
  assert(v == "from other lib");
  trace("success");
}
