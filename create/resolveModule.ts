import * as api from "./__warpo_create";

export class ModuleResolve {
  packageName!: string;
  setPackagePath(packagePath: string): void {
    api.setPackagePath(this.packageName, packagePath);
  }
}

export type Fn = (task: ModuleResolve) => void;
export function onModuleResolve(fn: Fn): void {
  api.onModuleResolve(fn.index, idof<ModuleResolve>());
}
