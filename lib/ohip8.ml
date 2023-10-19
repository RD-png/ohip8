type chip_context =
  { mutable memory  : Memory.t;
    mutable display : Display.t
  } [@@deriving show]


let create_chip_context =
  { memory  = Memory.create;
    display = Display.init
  }
;;
