type chip_context = { mutable memory : Memory.t;
                      mutable display : Display.t
                    }

val create_chip_context : chip_context

val pp_chip_context : Format.formatter -> chip_context -> unit
val show_chip_context : chip_context -> string
