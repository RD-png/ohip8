type chip_context = {
  mutable memory  : Memory.t;
  mutable display : Display.t;
  stack           : int Stack.t;
  delay_timer     : int;
  sound_timer     : int
}

val create_chip_context : chip_context
val execute : int -> int -> chip_context -> int
