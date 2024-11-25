/// @desc SETTINGS

// Coroutines accept few settings.
// These are prototype-specific, not per active coroutine task.
COROUTINE 
  name: "Coroutine",
  desc: "This is a coroutine, which will print hello world in 4 seconds.",
  slot: 1.0,
  scoped: true,
BEGIN
  show_debug_message("Wait 4 seconds...");
  DELAY 4_000.0 MILLIS
  show_debug_message("Hei maailma!");
FINISH DISPATCH














