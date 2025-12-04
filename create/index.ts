import * as api from "./__warpo_create";
import { __collect } from "rt/index";

__collect(); // trigger GC to ensure the env is loaded.
export const __dirname: string = api.getCreateFileDirName();
