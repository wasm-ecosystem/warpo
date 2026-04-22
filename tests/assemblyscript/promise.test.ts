import { describe, expect, test } from "warpo/test";
import { _AsPromiseBase } from "promise";

class Task {
  constructor(func: () => void) {
    this.func = func;
  }
  func: () => void;
}

class TaskQueue {
  private queue: Task[] = new Array<Task>();

  addTask(func: () => void): void {
    const task = new Task(func);
    this.queue.push(task);
  }

  run(): void {
    while (this.queue.length > 0) {
      const task = this.queue.shift();
      if (task) {
        task.func();
      }
    }
  }
}

const taskQueue = new TaskQueue();

function asyncAPI(func: () => void): void {
  taskQueue.addTask(func);
}

class C4 {
  a: string = "hello";
}

function api1(ms: i32): Promise<string> {
  return new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
    asyncAPI(() => {
      resolve(`waited ${ms}ms`);
    });
  });
}

function api2(): Promise<C4> {
  return new Promise<C4>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
    asyncAPI(() => {
      const c4 = new C4();
      c4.a = "abc";
      resolve(c4);
    });
  });
}

function api3(label: string): Promise<string> {
  return new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
    asyncAPI(() => {
      resolve(label);
    });
  });
}

function awaiter(fnc: (value: Object | null) => _AsPromiseBase | null): _AsPromiseBase {
  let drive: (value: Object | null) => _AsPromiseBase;
  drive = (value: Object | null): _AsPromiseBase => {
    let promise: _AsPromiseBase | null = fnc(value);
    if (promise != null) {
      return promise.thenBase(drive);
    } else {
      return new _AsPromiseBase((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        resolve(null);
      });
    }
  };
  return drive(null);
}

describe("test promise", () => {
  test("promise then", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          resolve("resolve 1");
        });
      })
        .then<C4>((value: string | null) => {
          log.push("then1: " + (value as string));
          return new Promise<C4>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
            asyncAPI(() => {
              const c4 = new C4();
              c4.a = "c4";
              resolve(c4);
            });
          });
        })
        .then<Object>((value: C4 | null) => {
          log.push("then2: " + value!.a);
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(2);
    expect(log[0]).equal("then1: resolve 1");
    expect(log[1]).equal("then2: c4");
  });

  test("promise recursive", () => {
    const log = new Array<string>();
    function testBody(): void {
      let label: i32 = 0;
      let c4: C4;

      function inner(value: Object | null): _AsPromiseBase | null {
        switch (label) {
          case 0:
            c4 = new C4();
            log.push("start");
            label = 1;
            return api1(1) as _AsPromiseBase;
          case 1:
            const result = value as string;
            log.push("api1: " + result);
            label = 2;
            return api2() as _AsPromiseBase;
          case 2:
            const result2 = value as C4;
            log.push("api2: " + result2.a);
            label = 3;
            return null;
        }
        return null;
      }

      awaiter(inner).thenBase((v: Object | null): Object | null => {
        log.push("done");
        return null;
      });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(4);
    expect(log[0]).equal("start");
    expect(log[1]).equal("api1: waited 1ms");
    expect(log[2]).equal("api2: abc");
    expect(log[3]).equal("done");
  });

  test("promise all", () => {
    const log = new Array<string>();
    function testBody(): void {
      const p1 = api3("api1");
      const p2 = api3("api2");
      const p3 = api3("api3");

      Promise.all([p1, p2, p3]).then<Object>((value: (Object | null)[] | null): Object | null => {
        let msg = "all done:";
        for (let i = 0; i < value!.length; i++) {
          msg += " " + (value![i] as string);
        }
        log.push(msg);
        return null;
      });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(1);
    expect(log[0]).equal("all done: api1 api2 api3");
  });

  test("promise catch", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          reject("error reason");
        });
      })
        .then<Object>((value: string | null) => {
          log.push("then: " + (value as string));
          return null;
        })
        .catch<Object>((reason: Object | null): Object | null => {
          log.push("catch: " + (reason as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(1);
    expect(log[0]).equal("catch: error reason");
  });

  test("promise then onReject returns promise", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          reject("initial error");
        });
      })
        .then<string>(
          (value: string | null) => {
            log.push("fulfilled");
            return new Promise<string>(
              (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
                asyncAPI(() => {
                  resolve("from fulfill");
                });
              }
            );
          },
          (reason: Object | null): Object | null => {
            log.push("rejected: " + (reason as string));
            return new Promise<string>(
              (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
                asyncAPI(() => {
                  resolve("recovered");
                });
              }
            );
          }
        )
        .then<Object>((value: string | null) => {
          log.push("after: " + (value as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(2);
    expect(log[0]).equal("rejected: initial error");
    expect(log[1]).equal("after: recovered");
  });

  test("promise then onFulfill returns promise", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          resolve("hello");
        });
      })
        .then<string>(
          (value: string | null) => {
            log.push("fulfilled: " + (value as string));
            return new Promise<string>(
              (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
                asyncAPI(() => {
                  resolve("chained");
                });
              }
            );
          },
          (reason: Object | null): Object | null => {
            log.push("rejected");
            return null;
          }
        )
        .then<Object>((value: string | null) => {
          log.push("after: " + (value as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(2);
    expect(log[0]).equal("fulfilled: hello");
    expect(log[1]).equal("after: chained");
  });

  test("onFulfill null passes value through", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          resolve("passthrough");
        });
      })
        .catch<string>((reason: Object | null): Object | null => {
          log.push("catch");
          return null;
        })
        .then<Object>((value: string | null) => {
          log.push("then: " + (value as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(1);
    expect(log[0]).equal("then: passthrough");
  });

  test("onFulfill returns promise that rejects", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          resolve("hello");
        });
      })
        .then<string>((value: string | null) => {
          log.push("fulfilled: " + (value as string));
          return new Promise<string>(
            (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
              asyncAPI(() => {
                reject("inner reject");
              });
            }
          );
        })
        .then<Object>((value: string | null) => {
          log.push("then2: " + (value as string));
          return null;
        })
        .catch<Object>((reason: Object | null): Object | null => {
          log.push("catch: " + (reason as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(2);
    expect(log[0]).equal("fulfilled: hello");
    expect(log[1]).equal("catch: inner reject");
  });

  test("onReject returns plain value", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          reject("error");
        });
      })
        .then<string>(
          (value: string | null) => {
            log.push("fulfilled");
            return null;
          },
          (reason: Object | null): Object | null => {
            log.push("rejected: " + (reason as string));
            return "recovered value";
          }
        )
        .then<Object>((value: string | null) => {
          log.push("then: " + (value as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(2);
    expect(log[0]).equal("rejected: error");
    expect(log[1]).equal("then: recovered value");
  });

  test("onReject returns promise that rejects", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          reject("first error");
        });
      })
        .then<string>(
          (value: string | null) => {
            log.push("fulfilled");
            return null;
          },
          (reason: Object | null): Object | null => {
            log.push("rejected: " + (reason as string));
            return new Promise<string>(
              (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
                asyncAPI(() => {
                  reject("second error");
                });
              }
            );
          }
        )
        .then<Object>((value: string | null) => {
          log.push("then");
          return null;
        })
        .catch<Object>((reason: Object | null): Object | null => {
          log.push("catch: " + (reason as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(2);
    expect(log[0]).equal("rejected: first error");
    expect(log[1]).equal("catch: second error");
  });

  test("sync resolve then", () => {
    const log = new Array<string>();
    function testBody(): void {
      Promise.resolve<string>("sync value").then<Object>((value: string | null) => {
        log.push("then: " + (value as string));
        return null;
      });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(1);
    expect(log[0]).equal("then: sync value");
  });

  test("sync reject catch", () => {
    const log = new Array<string>();
    function testBody(): void {
      Promise.reject<string>("sync error").catch<Object>((reason: Object | null): Object | null => {
        log.push("catch: " + (reason as string));
        return null;
      });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(1);
    expect(log[0]).equal("catch: sync error");
  });

  test("then catch then recovery chain", () => {
    const log = new Array<string>();
    function testBody(): void {
      new Promise<string>((resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
        asyncAPI(() => {
          resolve("start");
        });
      })
        .then<string>((value: string | null) => {
          log.push("then1: " + (value as string));
          return new Promise<string>(
            (resolve: (value: Object | null) => void, reject: (reason: Object | null) => void) => {
              asyncAPI(() => {
                reject("fail");
              });
            }
          );
        })
        .catch<string>((reason: Object | null): Object | null => {
          log.push("catch: " + (reason as string));
          return "recovered";
        })
        .then<Object>((value: string | null) => {
          log.push("then2: " + (value as string));
          return null;
        });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(3);
    expect(log[0]).equal("then1: start");
    expect(log[1]).equal("catch: fail");
    expect(log[2]).equal("then2: recovered");
  });

  test("promise any", () => {
    const log = new Array<string>();
    function testBody(): void {
      const p1 = api3("api1");
      const p2 = api3("api2");
      const p3 = api3("api3");

      Promise.any([p1, p2, p3]).then<Object>((value: (Object | null) | null): Object | null => {
        log.push("any done: " + (value as string));
        return null;
      });
    }
    taskQueue.addTask(testBody);
    taskQueue.run();
    expect(log.length).equal(1);
    expect(log[0]).equal("any done: api1");
  });
});
