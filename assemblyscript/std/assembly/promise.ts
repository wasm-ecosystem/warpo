enum _AsPromiseState {
  Pending,
  Fulfilled,
  Rejected,
}

export class _AsPromiseBase {
  private onThen: ((value: Object | null) => void) | null = null;
  private onCatch: ((reason: Object | null) => void) | null = null;
  private state: _AsPromiseState = _AsPromiseState.Pending;
  private fulfilledValue: Object | null = null;
  private rejectedReason: Object | null = null;
  constructor(executor: (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => void) {
    const handleResolve = (value: Object | null): void => {
      if (this.state == _AsPromiseState.Pending) {
        this.state = _AsPromiseState.Fulfilled;
        this.fulfilledValue = value;
        if (this.onThen) {
          this.onThen(value);
        }
      }
    };

    const handleReject = (reason: Object | null): void => {
      if (this.state == _AsPromiseState.Pending) {
        this.state = _AsPromiseState.Rejected;
        this.rejectedReason = reason;
        if (this.onCatch) {
          this.onCatch(reason);
        }
      }
    };

    executor(handleResolve, handleReject);
  }

  thenBase(
    onFulfilled: ((value: Object | null) => Object | null) | null,
    onRejected: ((reason: Object | null) => Object | null) | null = null
  ): _AsPromiseBase {
    return new _AsPromiseBase((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
      this.onThen = (value: Object | null) => {
        if (onFulfilled) {
          const result = onFulfilled(value);
          if (result instanceof _AsPromiseBase) {
            (result as _AsPromiseBase).thenBase(
              (v: Object | null): Object | null => {
                resolve(v);
                return null;
              },
              (reason: Object | null): Object | null => {
                reject(reason);
                return null;
              }
            );
          } else {
            //returns a value, resolve it
            resolve(result);
          }
        } else {
          resolve(value);
        }
      };

      this.onCatch = (reason: Object | null) => {
        if (onRejected) {
          const result = onRejected(reason);
          if (result instanceof _AsPromiseBase) {
            (result as _AsPromiseBase).thenBase(
              (v: Object | null): Object | null => {
                resolve(v);
                return null;
              },
              (newReason: Object | null): Object | null => {
                reject(newReason);
                return null;
              }
            );
          } else {
            resolve(result);
          }
        } else {
          reject(reason);
        }
      };

      if (this.state === _AsPromiseState.Fulfilled) {
        this.onThen(this.fulfilledValue);
      } else if (this.state === _AsPromiseState.Rejected) {
        this.onCatch(this.rejectedReason);
      }
    });
  }
}

export class Promise<T> extends _AsPromiseBase {
  then<U>(
    onFulfilled: ((value: T | null) => Object | null) | null,
    onRejected: ((reason: Object | null) => Object | null) | null = null
  ): Promise<U> {
    const onFulfilledWrapper = (value: Object | null): Object | null => {
      return onFulfilled ? onFulfilled(value as T | null) : value;
    };
    const p: _AsPromiseBase = super.thenBase(onFulfilledWrapper, onRejected);
    return new Promise<U>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
      p.thenBase(
        (value: Object | null): Object | null => {
          resolve(value);
          return null;
        },
        (reason: Object | null): Object | null => {
          reject(reason);
          return null;
        }
      );
    });
  }

  catch<U>(onRejected: (reason: Object | null) => Object | null): Promise<U> {
    return this.then<U>(null, onRejected);
  }

  static all(promiseArr: _AsPromiseBase[]): Promise<(Object | null)[]> {
    return new Promise<(Object | null)[]>(
      (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        let counter = 0;
        const values: (Object | null)[] = new Array<Object | null>();
        for (let i = 0; i < promiseArr.length; i++) {
          promiseArr[i].thenBase((value: Object | null): Object | null => {
            values.push(value);
            counter++;
            if (counter == promiseArr.length) {
              resolve(values);
            }
            return null;
          });
        }
      }
    );
  }

  static any(promiseArr: _AsPromiseBase[]): Promise<Object | null> {
    let resolved = false;
    return new Promise<Object | null>(
      (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        for (let i = 0; i < promiseArr.length; i++) {
          promiseArr[i].thenBase((value: Object | null): Object | null => {
            if (!resolved) {
              resolved = true;
              resolve(value);
            }
            return null;
          });
        }
      }
    );
  }

  static resolve<U>(value: U | null): Promise<U> {
    return new Promise<U>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
      resolve(value);
    });
  }

  static reject<U>(reason: Object | null): Promise<U> {
    return new Promise<U>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
      reject(reason);
    });
  }
}
