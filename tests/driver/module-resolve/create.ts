import * as resolveModule from "../../../create/resolveModule";
import { __dirname } from "../../../create/index";

resolveModule.onModuleResolve((task: resolveModule.ModuleResolve): void => {
  if (task.packageName === "@as/custom") {
    task.setPackagePath(__dirname + "/node_modules/@as/other");
  }
});
