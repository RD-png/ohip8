type pixel =
  | Transparent
  | Drawn
[@@deriving show]

type t = pixel array [@@deriving show]

let init =
  Array.make (64 * 32) Transparent
