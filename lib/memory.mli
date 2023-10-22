type t =
  { mutable pc       : int;
    mutable i        : int;
    mutable register : int array
  }

val font : int list
val create : t
val fetch : t -> int
val get : int -> t -> int
val jump : int -> t -> unit
val set : int -> int -> t -> unit
val add : int -> int -> t -> unit
