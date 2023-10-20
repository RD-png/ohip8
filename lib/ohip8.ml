type chip_context =
  { mutable memory  : Memory.t;
    mutable display : Display.t;
    stack           : int Stack.t;
    delay_timer     : int;
    sound_timer     : int
  }

exception Invalid_opcode of string;;

let create_chip_context =
  { memory      = Memory.create;
    display     = Display.init;
    stack       = Stack.create ();
    delay_timer = 0;
    sound_timer = 0
  }
;;

(* Maybe move this logic to a decoder module *)

let nibble byte shift bound =
  Int.shift_left (Int.logand byte bound) shift
;;

let decode opcode =
  let optype = nibble opcode 4 0xF0 in
  match optype with
  | 0 -> () (* 00E0 - Clear Screen *)
  | 1 -> () (* 1NNN - Jump *)
  | 2 -> () (* 6XNN - Set Register VX *)
  | 3 -> () (* 7XNN - Add Value To Register VX *)
  | 4 -> () (* ANNN - Set Index Register I *)
  | 5 -> () (* DXYN - Display / Draw *)
  | _ -> raise (Invalid_opcode (Int.to_string optype))
