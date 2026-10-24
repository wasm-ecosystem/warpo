let i: i32 = 0;
let j: i32 = 7;
let k: i32 = 1;

i = j
++k

assert(i == 7);
assert(k == 2);

let invokeCallbackCalls: i32 = 0;
let callbackCalls: i32 = 0;
function invokeCallback(callback: () => i32): () => i32 {
	invokeCallbackCalls++;
	return callback;
}
let callbackResult = invokeCallback
(() => {
	callbackCalls++;
	return 1;
})();
assert(callbackResult == 1);
assert(invokeCallbackCalls == 1);
assert(callbackCalls == 1);