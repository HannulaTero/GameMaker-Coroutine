/// @desc TRIGGERS.


// Coroutines can have "triggers", which execute code in certain events.
// These are not part of regular execution loop of coroutine task.
// Therefore you cannot use coroutine syntax or logic within triggers.
// -> Note, you can launch another coroutine task, but I don't think you want do that.
// Trigger -keywords start with "ON_*", and you can have multiple different triggers.


KORUTIINI 

  // Settings come before any triggers.
  name: "Coroutine example",
  desc: "Here are settings."
  
  // Then you can optionally define any trigger -action.
  ON_INIT      KorutiiniExample_Log("Triggered: onInit");     // Once when coroutine is created.
  ON_YIELD     KorutiiniExample_Log("Triggered: onYield");    // Whenever coroutine yields, from code or frame-time is not enough.
  ON_PAUSE     KorutiiniExample_Log("Triggered: onPause");    // Whenever coroutine is paused, from code or user-called.
  ON_RESUME    KorutiiniExample_Log("Triggered: onResume");   // Whenever coroutine resumes from paused state.
  ON_LAUNCH    KorutiiniExample_Log("Triggered: onLaunch");   // Coroutine begins execution from yield or pause.
  ON_CANCEL    KorutiiniExample_Log("Triggered: onCancel");   // Coroutine is cancelled, will not execute body anymore.
  ON_COMPLETE  KorutiiniExample_Log("Triggered: onComplete"); // Once when coroutine reached finish-state.
  ON_CLEANUP   KorutiiniExample_Log("Triggered: onCleanup");  // Once when coroutine is Destroyed.
  ON_ERROR     KorutiiniExample_Log("Triggered: onError");    // Whenever error is met. Coroutine tries skip to next execution step.
  
  // Finally coroutine body definition.
  BEGIN
    REPEAT 5 THEN
      KorutiiniExample_Log(" - Executing a loop!");
    END
    REPEAT 5 THEN
      DELAY 0.2 SECONDS
      KorutiiniExample_Log(" - Executing a loop with delay!");
    END
  FINISH
  
DISPATCH





