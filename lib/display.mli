type pixel = Transparent | Drawn
type t = pixel array

val init : pixel array
val clear : t -> unit
val draw : int -> int -> int -> t -> unit
