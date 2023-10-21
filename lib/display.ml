type pixel =
  | Transparent
  | Drawn

type t = pixel array

let init =
  Array.make (64 * 32) Transparent

let clear t =
  Array.iteri (fun addr _ -> t.(addr) <- Transparent) t
