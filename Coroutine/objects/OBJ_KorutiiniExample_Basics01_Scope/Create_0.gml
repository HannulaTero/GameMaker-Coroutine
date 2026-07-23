/// @desc SCOPE.

// In coroutines, you usually cannot use local variables "var i = 0;" because of code that macros generate.
// So the best practice is to just always to use instance/struct variables.
value = 100;


// By default, coroutines have their own separate scope,
// which makes coroutine encapsulated, and caller variables are protected. 
KORUTIINI BEGIN
  value = 200;
  KorutiiniExample_Log(value);
FINISH DISPATCH


// scope includes "this" variable, which is reference to caller.
// This way you can access and edit variables of caller within coroutine.
KORUTIINI BEGIN
  value = 200;
  KorutiiniExample_Log(value);
  KorutiiniExample_Log(this.value);
FINISH DISPATCH


// Sometimes it's better to use caller's scope directly instead.
// This can be done by defining coroutine non-scoped. 
KORUTIINI scoped: false BEGIN
  KorutiiniExample_Log(value);
FINISH DISPATCH


// Later examples will showcase, how to explicitly define who is caller, whether scoped or not.
// But as you saw, coroutines accept parameters to define their behaviour.




