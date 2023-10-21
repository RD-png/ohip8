open Ohip8

(* We will set a default speed of 700 instructions per second, however it
   is configurable from the command line. *)

let execute _action frequency =
  if frequency > 0
  then 1
  else 2
;;

let rec run context frequency =
  let opcode = Memory.fetch context.memory in
  let action = decode opcode context in
  let frequency' = execute action frequency in
  run context frequency'
;;

let () =
  let context = create_chip_context in
  run context 700
;;
