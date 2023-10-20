type t =
  { mutable pc       : int;
    mutable register : int array
  }

val font : int list
val create : t
val fetch : t -> int
