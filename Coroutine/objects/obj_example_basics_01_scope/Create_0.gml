/// @desc SCOPE.

value = 100;

// By default, coroutines have their own separate scope,
// which makes coroutine encapsulated, and caller variables are protected. 
COROUTINE BEGIN
  value = 200;
  show_debug_message(value);
FINISH DISPATCH


// scope includes "this" variable, which is reference to caller.
// This way you can access and edit variables of caller within coroutine.
COROUTINE BEGIN
  value = 200;
  show_debug_message(value);
  show_debug_message(this.value);
FINISH DISPATCH


// Sometimes it's better to use caller's scope directly instead.
// This can be done by defining coroutine non-scoped. 
COROUTINE scoped: false BEGIN
  show_debug_message(value);
FINISH DISPATCH


// Later examples will showcase, how to explicitly define who is caller, whether scoped or not.
// But as you saw, coroutines accept parameters to define their behaviour.




