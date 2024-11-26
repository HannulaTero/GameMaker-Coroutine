/// @desc TRIGGERS.


// Coroutines can have "triggers", which execute code in certain events.
// These are not part of regular execution loop of coroutine task.
// Therefore you cannot use coroutine syntax or logic within triggers.
// Trigger -keywords start with "ON_*", and you can have multiple different triggers.


COROUTINE 

  // Settings come before any triggers.
  name: "Coroutine example",
  desc: "Here are settings."
  
  // Then you can optionally define any trigger -action.
  ON_INIT      show_debug_message("Triggered: onInit");     // Once when coroutine is created.
  ON_YIELD     show_debug_message("Triggered: onYield");    // Whenever coroutine yields, from code or frame-time is not enough.
  ON_PAUSE     show_debug_message("Triggered: onPause");    // Whenever coroutine is paused, from code or user-called.
  ON_RESUME    show_debug_message("Triggered: onResume");   // Whenever coroutine resumes from paused state.
  ON_LAUNCH    show_debug_message("Triggered: onLaunch");   // Coroutine begins execution from yield or pause.
  ON_CANCEL    show_debug_message("Triggered: onCancel");   // Coroutine is cancelled, will not execute body anymore.
  ON_COMPLETE  show_debug_message("Triggered: onComplete"); // Once when coroutine reached finish-state.
  ON_CLEANUP   show_debug_message("Triggered: onCleanup");  // Once when coroutine is Destroyed.
  ON_ERROR     show_debug_message("Triggered: onError");    // Whenever error is met. Coroutine tries skip to next execution step.
  
  // Finally coroutine body definition.
  BEGIN
    REPEAT 5 THEN
      show_debug_message(" - Executing a loop!");
    END
    REPEAT 5 THEN
      DELAY 0.2 SECONDS
      show_debug_message(" - Executing a loop with delay!");
    END
  FINISH
  
DISPATCH





