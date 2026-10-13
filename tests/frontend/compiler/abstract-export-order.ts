namespace N {
  export abstract class Valid {}
  abstract class C {}
  // prettier-ignore
  abstract export class Invalid {}
  // prettier-ignore
  export class Duplicate {}
}

ERROR("EOF");
