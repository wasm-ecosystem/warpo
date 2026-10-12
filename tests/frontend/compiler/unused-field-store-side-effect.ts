class Packet {
  unused: i32 = 0;
}

let state: i32 = 0;

function sideEffect(): i32 {
  state += 1;
  return 7;
}

function write(packet: Packet): void {
  packet.unused = sideEffect();
}

write(new Packet());
assert(state == 1);
