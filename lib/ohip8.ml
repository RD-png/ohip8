type chip_context =
  { mutable memory  : Memory.t;
    mutable display : Display.t;
    stack           : int Stack.t;
    delay_timer     : int;
    sound_timer     : int
  }

let create_chip_context =
  { memory      = Memory.create;
    display     = Display.init;
    stack       = Stack.create ();
    delay_timer = 0;
    sound_timer = 0
  }
;;
