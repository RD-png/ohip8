type chip_context =
  { memory  : Memory.t
  }

let create_chip_context =
  { memory = Memory.create }
