# @copyright Copyright (C) 2025 BMW Group

from typing import Tuple


MAX_LENGTH = 10


class u:
    @staticmethod
    def decode(b: bytes) -> Tuple[int, int]:
        """Decode the unsigned leb128 encoded bytearray"""
        r = 0
        i = None
        for i, e in enumerate(b):
            r = r + ((e & 0x7F) << (i * 7))
            if e & 0x80 == 0x00:
                break
        assert i is not None
        return r, i + 1


class i:
    @staticmethod
    def decode(b: bytes) -> Tuple[int, int]:
        """Decode the signed leb128 encoded bytearray"""
        r = 0
        i = None
        e = None
        for i, e in enumerate(b):
            r = r + ((e & 0x7F) << (i * 7))
            if e & 0x80 == 0x00:
                break
        assert e is not None and i is not None
        if e & 0x40 != 0:
            r |= -(1 << (i * 7) + 7)
        return r, i + 1
