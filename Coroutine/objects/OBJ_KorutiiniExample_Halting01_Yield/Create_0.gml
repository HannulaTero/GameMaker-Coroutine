/// @desc YIELD.


// Yield is way to halt execution for rest of the frame for given coroutine task.
// This allows other tasks to also execute during the frame.
KORUTIINI BEGIN
  KorutiiniExample_Log("[0] One...");
  YIELD
  KorutiiniExample_Log("[0] Two...");
  YIELD
  KorutiiniExample_Log("[0] Three...");
  YIELD
  KorutiiniExample_Log("[0] GO!");
  YIELD
FINISH DISPATCH


// Yielding and giving turns for other tasks is important especially if task would take a long time and dry out all frame-budget.
// Because coroutine is for games, coroutine task manager will automatically yield task if it is taking too long time. 

// Note, that between order between independent tasks is not quaranteed to be same as their dispatching order.
// If there are lot of tasks, and frame-budget is exceeding all the time, it is good to have random order to give each task equal change.
KORUTIINI BEGIN
  YIELD
  KorutiiniExample_Log("[1] Hey!");
  YIELD
  KorutiiniExample_Log("[1] Hoy!");
  YIELD
  KorutiiniExample_Log("[1] Hiya!");
  YIELD
  KorutiiniExample_Log("[1] Hoya!");
FINISH DISPATCH


// You can utilize the triggers too. These are useful, if you are using gpu-states, surfaces or shaders.
// This means you can set to global states to correct state for coroutine execution, and then return to previous one.
KORUTIINI 

ON_YIELD  KorutiiniExample_Log("Trigger: [2] Yielded");
ON_LAUNCH KorutiiniExample_Log("Trigger: [2] Launched");

BEGIN
  YIELD
  KorutiiniExample_Log("[2] ...!");
  KorutiiniExample_Log("[2] ooo!");
  YIELD
  KorutiiniExample_Log("[2] OOOO!");
  KorutiiniExample_Log("[2] 0000!");
FINISH DISPATCH