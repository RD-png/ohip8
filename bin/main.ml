open Ohip8

(* We will set a default speed of 700 instructions per second, however it
   is configurable from the command line. *)

let rec run context frequency =
  let opcode = Memory.fetch context.memory in
  let remaining_frequency = execute opcode frequency context in
  run context remaining_frequency
;;

let () =
  let context = create_chip_context in
  run context 700
;;
