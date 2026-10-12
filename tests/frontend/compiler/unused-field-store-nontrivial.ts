class Packet {
  private value_: i32;
  private writeCount_: i32;

  get value(): i32 {
    return this.value_;
  }

  set value(value: i32) {
    this.value_ = value;
    this.writeCount_ += 1;
  }

  get writeCount(): i32 {
    return this.writeCount_;
  }
}

function writeValue(packet: Packet): void {
  packet.value = 1;
}

function getWriteCount(packet: Packet): i32 {
  return packet.writeCount;
}

const packet = new Packet();
writeValue(packet);
assert(getWriteCount(packet) == 1);
