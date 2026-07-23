/// @desc AWAIT


// AWAIT, and it's cousins, are ways to halt execution until some condition is met.
// The regular AWAIT requirement is boolean value: true.


// Here is example task, which waits until another one is one.
taskA = KORUTIINI BEGIN 
  KorutiiniExample_Log("Task A is waiting...");
  AWAIT choose(true, false) PASS
  
  KorutiiniExample_Log("Task A is working...");
  DELAY 0.5 SECONDS
  KorutiiniExample_Log("Task A is done!");
FINISH DISPATCH


// Coroutine tasks have "IsFinished()" -method, which can be utilized for waiting other task to finish first..
taskB = KORUTIINI BEGIN
  // Wait previous task to finish.
  KorutiiniExample_Log("Task B is waiting...");
  AWAIT this.taskA.IsFinished() PASS
  
  // Begin working.
  KorutiiniExample_Log("Task B is working...");
  DELAY 1.5 SECONDS
  KorutiiniExample_Log("Task B is done!");
FINISH DISPATCH


// AWAIT_KORUTIINI awaits given task, so it does not require "IsFinished".
// This also accepts array of tasks, so it can wait for multiple coroutines at once.
taskC = KORUTIINI BEGIN
  // Wait previous task to finish.
  KorutiiniExample_Log("Task C is waiting...");
  AWAIT_KORUTIINI this.taskB PASS
  
  // Begin working.
  KorutiiniExample_Log("Task C is working...");
  DELAY 1.5 SECONDS
  KorutiiniExample_Log("Task C is done!");

FINISH DISPATCH


// Also there are other AWAIT_* types, look for other related examples.
// Following will await all task's own subtasks, requests or listeners.
// AWAIT_SUBTASKS, AWAIT_REQUESTS, AWAIT_LISTENERS























