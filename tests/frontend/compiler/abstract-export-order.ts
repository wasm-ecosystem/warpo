namespace N {
  export abstract class Valid {}
  abstract class C {}
  // prettier-ignore
  abstract export class Invalid {}
  // prettier-ignore
  export export class Duplicate {}
}

ERROR("EOF");
