open Ohip8

let () =
  let context = create_chip_context in
  show_chip_context context |> print_endline
