import argparse
import vb_warp
from helper import wasm_utils

parser = argparse.ArgumentParser(description="run wasm module")
parser.add_argument("--module", help="path to the wasm file", required=True)
parser.add_argument("--target", help="target function to execute", required=True)
parser.add_argument("--signature", help="function signature", required=True)
parser.add_argument("args", nargs="*", help="Arguments")

args = parser.parse_args()

compile = vb_warp.Compiler()
module = compile.compile(wasm_utils.load_wasm_or_wat(args.module))

runtime = vb_warp.Runtime()
runtime.load(module)
runtime.start()


target: str = str(args.target)
signature: str = str(args.signature)
arguments = []

for c in signature:
    if c == "(":
        continue
    if c == ")":
        if not len(args.args) == 0:
            raise Exception("Too many arguments")
        break
    if len(args.args) == 0:
        raise Exception("Too less arguments")
    match c:
        case "i":
            arguments.append(vb_warp.i32(int(args.args.pop(0))))
        case "I":
            arguments.append(vb_warp.i64(int(args.args.pop(0))))
        case "f":
            arguments.append(vb_warp.f32(float(args.args.pop(0))))
        case "F":
            arguments.append(vb_warp.f64(float(args.args.pop(0))))


res = runtime.call(target, signature, arguments)

print(res)
