import { join } from "node:path";
import { fileURLToPath, URL } from "node:url";

export const projectRoot = join(fileURLToPath(new URL(".", import.meta.url)), "..", "..");
