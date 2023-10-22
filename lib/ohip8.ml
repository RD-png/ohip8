type chip_context =
  { mutable memory  : Memory.t;
    mutable display : Display.t;
    stack           : int Stack.t;
    delay_timer     : int;
    sound_timer     : int
  }

exception Invalid_opcode of string

let create_chip_context =
  { memory      = Memory.create;
    display     = Display.init;
    stack       = Stack.create ();
    delay_timer = 0;
    sound_timer = 0
  }
;;

let nibble byte shift mask =
  Int.shift_right (Int.logand byte mask) shift
;;

let decode opcode context =
  let optype = nibble opcode 12 0xF000 in
  match optype with
  | 0x00 ->
     Display.clear context.display
  | 0x01 ->
     let addr = Int.logand opcode 0x00FF in
     Memory.jump addr context.memory
  | 0x06 ->
     let value = nibble opcode 0 0x00FF in
     let addr = nibble opcode 8 0x0F00 in
     Memory.set addr value context.memory
  | 0x07 ->
     let value = nibble opcode 0 0x0FF in
     let addr = nibble opcode 8 0x0F00 in
     Memory.add addr value context.memory
  | 0x0A ->
     let addr = Int.logand opcode 0x00FF in
     context.memory.i <- addr
  | 0x0D ->
     let x = nibble opcode 8 0x0F00 in
     let y = nibble opcode 4 0x00F0 in
     let vx = Memory.get x context.memory in
     let vy = Memory.get y context.memory in
     let sprite_height = Int.logand opcode 0x000F in
     Display.draw vx vy sprite_height context.display
  | _ -> raise (Invalid_opcode (Int.to_string optype))
