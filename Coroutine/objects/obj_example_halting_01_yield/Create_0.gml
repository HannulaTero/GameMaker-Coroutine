/// @desc YIELD.


// Yield is way to halt execution for rest of the frame for given coroutine task.
// This allows other tasks to also execute during the frame.
COROUTINE BEGIN
  show_debug_message("[0] One...");
  YIELD
  show_debug_message("[0] Two...");
  YIELD
  show_debug_message("[0] Three...");
  YIELD
  show_debug_message("[0] GO!");
  YIELD
FINISH DISPATCH


// Yielding and giving turns for other tasks is important especially if task would take a long time and dry out all frame-budget.
// Because coroutine is for games, coroutine task manager will automatically yield task if it is taking too long time. 

// Note, that between order between independent tasks is not quaranteed to be same as their dispatching order.
// If there are lot of tasks, and frame-budget is exceeding all the time, it is good to have random order to give each task equal change.
COROUTINE BEGIN
  YIELD
  show_debug_message("[1] Hey!");
  YIELD
  show_debug_message("[1] Hoy!");
  YIELD
  show_debug_message("[1] Hiya!");
  YIELD
  show_debug_message("[1] Hoya!");
FINISH DISPATCH


// You can utilize the triggers too. These are useful, if you are using gpu-states, surfaces or shaders.
// This means you can set to global states to correct state for coroutine execution, and then return to previous one.
COROUTINE 

ON_YIELD  show_debug_message("Trigger: [2] Yielded");
ON_LAUNCH show_debug_message("Trigger: [2] Launched");

BEGIN
  YIELD
  show_debug_message("[2] ...!");
  show_debug_message("[2] ooo!");
  YIELD
  show_debug_message("[2] OOOO!");
  show_debug_message("[2] 0000!");
FINISH DISPATCH