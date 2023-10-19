type pixel = Transparent | Drawn

val pp_pixel : Format.formatter -> pixel -> unit
val show_pixel : pixel -> string

type t = pixel array

val pp : Format.formatter -> t -> unit
val show : t -> string
val init : pixel array
