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

let nibble byte mask shift =
  Int.shift_right (Int.logand byte mask) shift
;;

let execute opcode frequency context =
  let remaining_frequency = frequency - 10 in
  let optype = nibble opcode 0xF000 12 in
  let () = match optype with
  | 0x00 ->
     Display.clear context.display
  | 0x01 ->
     let addr = Int.logand opcode 0x0FFF in
     Memory.jump addr context.memory
  | 0x06 ->
     let addr = nibble opcode 0x0F00 8 in
     let value = Int.logand opcode 0x00FF in
     Memory.set addr value context.memory
  | 0x07 ->
     let addr = nibble opcode 0x0F00 8 in
     let value = Int.logand opcode 0x00FF in
     Memory.add addr value context.memory
  | 0x0A ->
     let addr = Int.logand opcode 0x0FFF in
     context.memory.i <- addr
  | 0x0D ->
     let x = nibble opcode 0x0F00 8 in
     let y = nibble opcode 0x00F0 4 in
     let sprite_height = Int.logand opcode 0x000F in

     let vx = Memory.get x context.memory in
     let vy = Memory.get y context.memory in
     Display.draw vx vy sprite_height context.display
  | _ ->
     raise (Invalid_opcode (Int.to_string optype))
  in
  remaining_frequency
;;
