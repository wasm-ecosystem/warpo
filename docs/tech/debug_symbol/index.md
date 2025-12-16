# Debug symbol layout

Currently debug symbols has two parts:

1. typescript source map file, which represents the mapping between source code and bytecode, this part is carried over from assemblyscript
2. Dwarf, which represents the class information, variable information.
   They are in following Wasm custom sections sections.
   - debug_info
   - debug_abbrev
   - debug_str

## Debug Abbreviation Definitions

### tag: DW_TAG_compile_unit

**hasChildren:** true

- `DW_AT_producer` -> `DW_FORM_strp`

### tag: DW_TAG_class_type

**hasChildren:** true

- `DW_AT_name` -> `DW_FORM_string`
- `DW_AT_byte_size` -> `DW_FORM_data4`
- `DW_AT_signature` -> `DW_FORM_data4` (runtime type ID)

### tag: DW_TAG_member

**hasChildren:** false

- `DW_AT_name` -> `DW_FORM_string`
- `DW_AT_type` -> `DW_FORM_ref4` (reference to type DIE)
- `DW_AT_data_member_location` -> `DW_FORM_data4` (offset in bytes)

### tag: DW_TAG_base_type

**hasChildren:** false

- `DW_AT_name` -> `DW_FORM_string`
- `DW_AT_byte_size` -> `DW_FORM_data1`

### tag: DW_TAG_template_type_parameter

**hasChildren:** false

- `DW_AT_type` -> `DW_FORM_ref4` (reference to type DIE)

### tag: DW_TAG_variable (Global)

**hasChildren:** false

- `DW_AT_name` -> `DW_FORM_string`
- `DW_AT_type` -> `DW_FORM_ref4` (reference to type DIE)

### tag: DW_TAG_variable (Local)

**hasChildren:** false

- `DW_AT_name` -> `DW_FORM_string`
- `DW_AT_type` -> `DW_FORM_ref4` (reference to type DIE)
- `DW_AT_location` -> `DW_FORM_data4` (Wasm local index)

### tag: DW_TAG_formal_parameter

**hasChildren:** false

- `DW_AT_name` -> `DW_FORM_string`
- `DW_AT_type` -> `DW_FORM_ref4` (reference to type DIE)
- `DW_AT_location` -> `DW_FORM_data4` (Wasm location index)

### tag: DW_TAG_subprogram

**hasChildren:** true

- `DW_AT_name` -> `DW_FORM_string`

### tag: DW_TAG_lexical_block

**hasChildren:** true

- `DW_AT_low_pc` -> `DW_FORM_addr` (start address)
- `DW_AT_high_pc` -> `DW_FORM_addr` (end address)

Topology dwarf debug symbol is ![here](./debugSymbol.excalidraw.svg)

### Example

```ts
class B {
  x: i32;
  y: f32;
}

class A {
  x: i32;
  b: B;
}
```

Debug symbol layout for the above classes:

```
DW_TAG_compile_unit
  DW_AT_producer: "warpo compiler"

  DW_TAG_base_type
    DW_AT_name: "i32"
    DW_AT_byte_size: 4

  DW_TAG_base_type
    DW_AT_name: "f32"
    DW_AT_byte_size: 4

  DW_TAG_class_type
    DW_AT_name: "B"
    DW_AT_byte_size: 8
    DW_AT_signature: 0x1001  // runtime type ID

    DW_TAG_member
      DW_AT_name: "x"
      DW_AT_type: 0x100  // reference to i32
      DW_AT_data_member_location: 0  // offset 0 bytes

    DW_TAG_member
      DW_AT_name: "y"
      DW_AT_type: 0x110  // reference to f32
      DW_AT_data_member_location: 4  // offset 4 bytes

  DW_TAG_class_type
    DW_AT_name: "A"
    DW_AT_byte_size: 12
    DW_AT_signature: 0x1002  // runtime type ID

    DW_TAG_member
      DW_AT_name: "x"
      DW_AT_type: 0x100  // reference to i32
      DW_AT_data_member_location: 0  // offset 0 bytes

    DW_TAG_member
      DW_AT_name: "b"
      DW_AT_type: 0x200  // reference to class B
      DW_AT_data_member_location: 4  // offset 4 bytes
```

The layout shows:

- **Class B** has a total size of 8 bytes (i32 + f32), with `x` at offset 0 and `y` at offset 4
- **Class A** has a total size of 12 bytes (i32 + reference to B), with `x` at offset 0 and `b` at offset 4
- Each member references its type using the offset of the corresponding type DIE
- Base types (i32, f32) are defined once and referenced by multiple members
