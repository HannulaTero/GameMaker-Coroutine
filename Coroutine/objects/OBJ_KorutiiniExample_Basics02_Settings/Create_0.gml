/// @desc SETTINGS

// Coroutines accept few settings.
// These are prototype-specific, not per active coroutine task.
KORUTIINI 
  name: "Coroutine",
  desc: "This is a coroutine, which will print hello world in 4 seconds.",
  slot: 1.0,
  scoped: true,
BEGIN
  KorutiiniExample_Log("Wait 4 seconds...");
  DELAY 4_000.0 MILLIS
  KorutiiniExample_Log("Hei maailma!");
FINISH DISPATCH














