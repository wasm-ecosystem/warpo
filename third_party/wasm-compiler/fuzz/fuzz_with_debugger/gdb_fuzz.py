import sys  # nopep8

print(f"Python version: {sys.version}")

import gdb
import os  # nopep8

sys.path.append(os.path.dirname(os.path.realpath(__file__)))  # nopep8
from dbg_fuzz import DbgFuzz  # nopep8


targetDir = os.getenv("VB_FUZZ_TARGET_DIR", ".")
execPrefix = os.getenv("VB_FUZZ_EXEC_PREFIX", "")
fuzzOffset = os.getenv("VB_FUZZ_OFFSET", "0")
nativeBuildFolder = os.getenv("VB_FUZZ_NATIVE_BUILD_FOLDER", "/")

generateBinaryAndBackupFailedModules = True
compileNatively = False


class GDBFuzz(DbgFuzz, gdb.Breakpoint):

    def __init__(
        self,
        targetDir: str,
        execPrefix: str,
        nativeBuildFolder: str,
        fuzzOffset: str,
        compileNatively: bool,
    ) -> None:
        DbgFuzz.__init__(
            self, targetDir, execPrefix, nativeBuildFolder, fuzzOffset, compileNatively
        )
        gdb.Breakpoint.__init__(self, "GDB_FUZZ_UPDATE")

    def stop(self) -> bool:
        return self.processBreakPoint()

    def getIntByVariableName(self, name: str) -> int:
        return int(gdb.parse_and_eval(name))

    def getAddressByVariableName(self, name: str) -> int:
        return int(gdb.parse_and_eval(f"&{name}"))

    def getBytesByVariableName(self, variableName: str, size: int) -> str:
        address = self.getAddressByVariableName(variableName)

        memoryView = gdb.inferiors()[0].read_memory(address, size)
        message = memoryView.tobytes()
        return message

    def setVariableInt(self, variableName: str, value: int) -> None:
        self.__setVariableByName(variableName, str(value))

    def setVariableBool(self, variableName: str, value: bool) -> None:
        self.__setVariableByName(variableName, "true" if value else "false")

    def setMemoryByAddress(self, address: int, data: bytes) -> None:
        gdb.inferiors()[0].write_memory(address, data, len(data))

    def __setVariableByName(self, variableName: str, value: str) -> None:
        gdb.execute(f"set var {variableName} = {value}")


gdb.execute("set pagination off")
gdb.execute("set confirm off")
gdb.execute("set verbose off")

GDBFuzz(targetDir, execPrefix, nativeBuildFolder, fuzzOffset, compileNatively)

print("Fuzzing in " + targetDir)

gdb.execute("continue")
gdb.execute("quit")
