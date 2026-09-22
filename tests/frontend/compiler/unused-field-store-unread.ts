class Packet {
  unused: i32;
}

function writeUnused(packet: Packet): i32 {
  packet.unused = 7;
  return 42;
}

assert(writeUnused(new Packet()) == 42);
