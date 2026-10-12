class Packet {
  value: i32;
}

function readValue(packet: Packet): i32 {
  return packet.value;
}

function writeValue(packet: Packet): void {
  packet.value = 1;
}

function readValueIndirect(packet: Packet): i32 {
  const reader: (packet: Packet) => i32 = readValue;
  return reader(packet);
}

const packet = new Packet();
writeValue(packet);
assert(readValueIndirect(packet) == 1);
