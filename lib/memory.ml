type t =
  { mutable pc       : int;
    mutable i        : int;
    mutable register : int array
  }

let font =
  [ 0xF0; 0x90; 0x90; 0x90; 0xF0; (* 0 *)
    0x20; 0x60; 0x20; 0x20; 0x70; (* 1 *)
    0xF0; 0x10; 0xF0; 0x80; 0xF0; (* 2 *)
    0xF0; 0x10; 0xF0; 0x10; 0xF0; (* 3 *)
    0x90; 0x90; 0xF0; 0x10; 0x10; (* 4 *)
    0xF0; 0x80; 0xF0; 0x10; 0xF0; (* 5 *)
    0xF0; 0x80; 0xF0; 0x90; 0xF0; (* 6 *)
    0xF0; 0x10; 0x20; 0x40; 0x40; (* 7 *)
    0xF0; 0x90; 0xF0; 0x90; 0xF0; (* 8 *)
    0xF0; 0x90; 0xF0; 0x10; 0xF0; (* 9 *)
    0xF0; 0x90; 0xF0; 0x90; 0x90; (* A *)
    0xE0; 0x90; 0xE0; 0x90; 0xE0; (* B *)
    0xF0; 0x80; 0x80; 0x80; 0xF0; (* C *)
    0xE0; 0x90; 0x90; 0x90; 0xE0; (* D *)
    0xF0; 0x80; 0xF0; 0x80; 0xF0; (* E *)
    0xF0; 0x80; 0xF0; 0x80; 0x80  (* F *)
  ]
;;

let create =
  let register = Array.make 4096 0 in
  let () = List.iteri (fun addr char -> register.(addr) <- char) font in
  { pc = 0;
    i = 0;
    register
  }
;;

let increment t =
  t.pc <- t.pc + 2
;;

let fetch t =
  let bit1 = Array.get t.register t.pc in
  let bit2 = Array.get t.register (t.pc + 1) in
  let opcode = Int.logor (Int.shift_left bit1 8) bit2 in
  let () = increment t in
  opcode
;;

let get addr t =
  Array.get t.register addr
;;

let jump addr t =
  t.pc <- addr
;;

let set addr value t =
  t.register.(addr) <- value
;;

let add addr value t =
  t.register.(addr) <- value + t.register.(addr)
;;
