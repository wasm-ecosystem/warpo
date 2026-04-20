// @ts-nocheck

// Compile with:  ./build/warpo/warpo_asc tools/heap_analyzer/tests/fixture/dwarfFixture.ts -o /tmp/warpo_test/dwarfFixture.wasm --debug
// =============================================================================

class Vector2 {
  x: f32;
  y: f32;

  constructor(x: f32, y: f32) {
    this.x = x;
    this.y = y;
  }
}

class Item {
  name: string;
  weight: i32;

  constructor(name: string, weight: i32) {
    this.name = name;
    this.weight = weight;
  }
}

// ---------------------------------------------------------------------------
// 2. Inheritance chain
// ---------------------------------------------------------------------------

class Entity {
  id: i32;
  position: Vector2;

  constructor(id: i32, x: f32, y: f32) {
    this.id = id;
    this.position = new Vector2(x, y);
  }
}

class Character extends Entity {
  name: string;
  hp: i32;

  constructor(id: i32, name: string, hp: i32, x: f32, y: f32) {
    super(id, x, y);
    this.name = name;
    this.hp = hp;
  }
}

class Player extends Character {
  inventory: Array<Item>;
  score: u32;

  constructor(id: i32, name: string, hp: i32, x: f32, y: f32) {
    super(id, name, hp, x, y);
    this.inventory = new Array<Item>();
    this.score = 0;
  }

  addItem(item: Item): void {
    this.inventory.push(item);
  }
}

class NPC extends Character {
  dialogue: string;

  constructor(id: i32, name: string, hp: i32, dialogue: string) {
    super(id, name, hp, 0.0, 0.0);
    this.dialogue = dialogue;
  }
}

// ---------------------------------------------------------------------------
// 3. Container with nested references (tree-like structure)
// ---------------------------------------------------------------------------

class TreeNode {
  value: i32;
  left: TreeNode | null;
  right: TreeNode | null;

  constructor(value: i32) {
    this.value = value;
    this.left = null;
    this.right = null;
  }
}

function buildTree(depth: i32, startVal: i32): TreeNode {
  const node = new TreeNode(startVal);
  if (depth > 0) {
    node.left = buildTree(depth - 1, startVal * 2);
    node.right = buildTree(depth - 1, startVal * 2 + 1);
  }
  return node;
}

// ---------------------------------------------------------------------------
// 4. Linked list (linear reference chain)
// ---------------------------------------------------------------------------

class ListNode {
  data: string;
  next: ListNode | null;

  constructor(data: string) {
    this.data = data;
    this.next = null;
  }
}

function buildLinkedList(items: string[]): ListNode {
  const head = new ListNode(items[0]);
  let current = head;
  for (let i = 1; i < items.length; i++) {
    const node = new ListNode(items[i]);
    current.next = node;
    current = node;
  }
  return head;
}

// ---------------------------------------------------------------------------
// 5. Map-like structure (array of key-value pairs)
// ---------------------------------------------------------------------------

class KVPair {
  key: string;
  value: string;

  constructor(key: string, value: string) {
    this.key = key;
    this.value = value;
  }
}

// ---------------------------------------------------------------------------
// 6. Global roots — these are in static data and should be detected as
//    global root references by the analyzer.
// ---------------------------------------------------------------------------

const GLOBAL_STRING: string = "I am a global string constant";
const GLOBAL_ARRAY: i32[] = [10, 20, 30, 40, 50];
let globalPlayer: Player | null = null;
let globalTree: TreeNode | null = null;

// ---------------------------------------------------------------------------
// 7. Pinned objects — explicitly pinned so GC keeps them alive.
// ---------------------------------------------------------------------------

let pinnedBuffer: ArrayBuffer | null = null;
let pinnedString: string | null = null;

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

export function _start(): void {
  // -- Strings of various sizes --
  const shortStr = "Hi";
  const mediumStr = "The quick brown fox jumps over the lazy dog";
  const longStr = mediumStr + " — " + mediumStr + " — " + mediumStr;

  // -- Typed arrays --
  const u8arr = new Uint8Array(64);
  for (let i = 0; i < 64; i++) u8arr[i] = <u8>(i & 0xff);

  const f64arr = new Float64Array(16);
  for (let i = 0; i < 16; i++) f64arr[i] = <f64>i * 1.5;

  const i32arr = new Int32Array(32);
  for (let i = 0; i < 32; i++) i32arr[i] = i * 100;

  // -- StaticArray --
  const staticArr = new StaticArray<i32>(10);
  for (let i = 0; i < 10; i++) staticArr[i] = i * 7;

  // -- Array of references --
  const items = new Array<Item>();
  items.push(new Item("Sword", 10));
  items.push(new Item("Shield", 15));
  items.push(new Item("Potion", 2));
  items.push(new Item("Scroll", 1));
  items.push(new Item("Bow", 8));

  // -- Players with inventories --
  const player1 = new Player(1, "Alice", 100, 10.5, 20.3);
  player1.addItem(new Item("Magic Staff", 12));
  player1.addItem(new Item("Health Potion", 1));
  player1.addItem(new Item("Ring of Power", 1));
  player1.score = 4200;

  const player2 = new Player(2, "Bob", 85, -5.0, 13.7);
  player2.addItem(new Item("Dagger", 3));
  player2.addItem(new Item("Lock pick", 1));
  player2.score = 1500;

  // -- NPCs --
  const npc1 = new NPC(100, "Villager", 50, "Welcome to our village!");
  const npc2 = new NPC(101, "Merchant", 40, "What would you like to buy?");
  const npc3 = new NPC(102, "Guard", 200, "Halt! Who goes there?");

  // -- Characters array (mixed inheritance) --
  const characters = new Array<Character>();
  characters.push(player1);
  characters.push(player2);
  characters.push(npc1);
  characters.push(npc2);
  characters.push(npc3);

  // -- Binary tree (depth=4 → 31 nodes with cross-references) --
  const tree = buildTree(4, 1);
  globalTree = tree;

  // -- Linked list --
  const list = buildLinkedList(["alpha", "beta", "gamma", "delta", "epsilon"]);

  // -- Set with primitive type --
  const primeSet = new Set<i32>();
  primeSet.add(2);
  primeSet.add(3);
  primeSet.add(5);

  // -- Set with reference type --
  const itemSet = new Set<Item>();
  itemSet.add(new Item("Amulet", 3));
  itemSet.add(new Item("Gem", 1));
  itemSet.add(new Item("Rune", 2));

  // -- Map with primitive key and value --
  const scoreMap = new Map<i32, i32>();
  scoreMap.set(1, 4200);
  scoreMap.set(2, 1500);
  scoreMap.set(3, 800);

  // -- Map with string key and reference value --
  const playerMap = new Map<string, Player>();
  playerMap.set("Alice", player1);
  playerMap.set("Bob", player2);

  // -- Map with reference key and reference value --
  const entityPositions = new Map<Character, Vector2>();
  entityPositions.set(npc1, new Vector2(10.0, 20.0));
  entityPositions.set(npc2, new Vector2(30.0, 40.0));
  entityPositions.set(npc3, new Vector2(50.0, 60.0));

  // -- Key-value pairs --
  const kvPairs = new Array<KVPair>();
  kvPairs.push(new KVPair("name", "HeapAnalyzer"));
  kvPairs.push(new KVPair("version", "1.0.0"));
  kvPairs.push(new KVPair("author", "dev"));

  // -- ArrayBuffer (raw bytes) --
  const rawBuf = new ArrayBuffer(256);

  // -- Pinned objects to test pinned-root detection --
  pinnedBuffer = changetype<ArrayBuffer>(__pin(changetype<usize>(new ArrayBuffer(128))));
  pinnedString = changetype<string>(__pin(changetype<usize>("I am pinned and cannot be collected")));

  // -- Assign to globals so they survive as global roots --
  globalPlayer = player1;

  // -- Create some local-only objects (not stored in globals) so they appear
  //    as stack/local roots at the time of a dump.
  const localOnly1 = new Vector2(99.0, -99.0);
  const localOnly2 = new Item("Ephemeral Key", 0);
  const localOnlyArr = new Array<string>();
  localOnlyArr.push("temp1");
  localOnlyArr.push("temp2");
  localOnlyArr.push("temp3");

  // -- Large allocation to exercise the TLSF allocator with bigger blocks --
  const bigArray = new Array<f64>(1024);
  for (let i = 0; i < 1024; i++) bigArray[i] = Math.sqrt(<f64>i);

  // -- Nested arrays (array of arrays) --
  const matrix = new Array<Array<i32>>();
  for (let row = 0; row < 4; row++) {
    const r = new Array<i32>();
    for (let col = 0; col < 4; col++) {
      r.push(row * 4 + col);
    }
    matrix.push(r);
  }

  // -- Use values to prevent the compiler from optimizing them away --
  assert(shortStr.length > 0);
  assert(mediumStr.length > 0);
  assert(longStr.length > 0);
  assert(u8arr.length == 64);
  assert(f64arr.length == 16);
  assert(i32arr.length == 32);
  assert(staticArr.length == 10);
  assert(items.length == 5);
  assert(characters.length == 5);
  assert(tree.value == 1);
  assert(list.data == "alpha");
  assert(kvPairs.length == 3);
  assert(rawBuf.byteLength == 256);
  assert(localOnly1.x == 99.0);
  assert(localOnly2.weight == 0);
  assert(localOnlyArr.length == 3);
  assert(bigArray.length == 1024);
  assert(matrix.length == 4);
  assert(GLOBAL_STRING.length > 0);
  assert(GLOBAL_ARRAY.length == 5);
  assert(primeSet.has(7));
  assert(itemSet.size == 3);
  assert(scoreMap.get(1) == 4200);
  assert(playerMap.has("Alice"));
  assert(entityPositions.size == 3);
}
