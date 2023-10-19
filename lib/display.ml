type t = int array [@@deriving show]

let init =
  Array.make (64 * 32) 0
