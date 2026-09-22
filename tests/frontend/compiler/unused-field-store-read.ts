class Packet {
  used: i32;
}

function writeUsed(packet: Packet): void {
  packet.used = 7;
}

function readUsed(packet: Packet): i32 {
  return packet.used;
}

const packet = new Packet();
writeUsed(packet);
assert(readUsed(packet) == 7);
