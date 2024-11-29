/// @desc FOREACH IN OBJECTS.


COROUTINE
  ON_CLEANUP
    instance_destroy(obj_example_instance);

  BEGIN 
    // Initializing different datastructures, which are acceptable.
    repeat(5)
    {
      instance_create_depth(random(room_width), random(room_height), 0, obj_example_instance);
    }
  
  
    // Objects are also supported iterables, it will iterate instances of given object.
    // Note, that this doesn't do any fail-safe if during iteration some instances are destroyed.
    PRINT "iterating over instances of 'obj_example_instance'.";
    FOREACH key, inst: value IN obj_example_instance THEN
      show_debug_message($"instance[{key}] = \{ x: {inst.x}, y: {inst.y} \};");
      DELAY 3 FRAMES
    END
    PRINT "done.";


  FINISH 
DISPATCH 













