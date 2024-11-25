/// @desc HELLO WORLD.

// Let's start with the most simplest coroutine: Nothing at all.
// This is valid, and executes empty coroutine, but that's not useful at all.
COROUTINE BEGIN FINISH DISPATCH


// So let's print hello world.
// This will create a new active coroutine, which will be executed end of the frame.
COROUTINE BEGIN 
  show_debug_message("HELLO WORLD!");
FINISH DISPATCH


// Following example is practically same as before, but with a delay.
// Other delay-types are: MICROS, MILLIS and FRAMES.
COROUTINE BEGIN
  DELAY 1.0 SECONDS
  show_debug_message("HELLO WORLD AGAIN!");
FINISH DISPATCH


// As you noticed, the executable code is placed between "COROUTINE BEGIN" and "FINISH DISPATCH".
// This is only place where you can put pausable code.
// Other examples will explain more about what those keywords will do.
