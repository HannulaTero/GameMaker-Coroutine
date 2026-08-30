/// @desc DISPATCH.

KorutiiniExample_Log("Handling dispatch examples.");
self.label = "Instance";


// After creating prototype, you can immediately use "DISPATCH" to create active coroutine-task.
// Task-handle is returned to control task outside the coroutine execution.
coroutine = KORUTIINI BEGIN 
  DELAY irandom_range(20, 30) FRAMES 
  KorutiiniExample_Log("I think, therefore I am.");
FINISH DISPATCH 


// Prototype can be used to dispatch new active tasks.
// You can think coroutine-prototype as a async-function,
// and "active task" as execution of the async-function.
prototype = KORUTIINI BEGIN 
  DELAY irandom_range(40, 60) FRAMES 
  KorutiiniExample_Log("You think, therefore you are?");
FINISH

coroutine = prototype.Dispatch();


// When you use "DISPATCH", caller will always be implicitly the current "self".
// With prototype Dispatch -call you can define explicit "this".
prototype = KORUTIINI BEGIN
  DELAY irandom_range(40, 60) FRAMES 
  KorutiiniExample_Log($"Coroutine 'this' is : {this.label}");
FINISH

coroutine = prototype.Dispatch(self);
coroutine = prototype.Dispatch({ label : "Struct" });


// Alongside passing explicit 'this', you may pass parameters struct,
// which are copied to coroutine-task.
// Be careful, as parameters are copied over even when task is not scoped.
prototype = KORUTIINI BEGIN
  DELAY irandom_range(40, 60) FRAMES 
  KorutiiniExample_Log($"task.x : {x}");
  KorutiiniExample_Log($"task.y : {y}");
  KorutiiniExample_Log($"this.x : {this.x}");
  KorutiiniExample_Log($"this.y : {this.y}");
FINISH

coroutine = prototype.Dispatch(self, {
  x : random(100),
  y : random(100),
});


// For convenience, you can make new task dispatches of same coroutine task.
// This is same as using task's prototype to dispatch new task.
prototype = KORUTIINI BEGIN
  DELAY irandom_range(40, 60) FRAMES 
  KorutiiniExample_Log($"Dispatching from coroutine-prototypes or -tasks.");
FINISH

anotherA = prototype.Dispatch();
anotherB = anotherA.prototype.Dispatch();
anotherC = anotherB.Dispatch();



// All tasks of same prototype utilizes same shared structure and settings of prototype.
// So be careful if you tinker tasks in non-intended ways.









