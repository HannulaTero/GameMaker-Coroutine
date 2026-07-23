/// @desc FOREACH IN OBJECTS.


KORUTIINI
  ON_CLEANUP
    instance_destroy(OBJ_KorutiiniExample_EntityA);

  BEGIN 
    // Initializing different datastructures, which are acceptable.
    repeat(5)
    {
      instance_create_depth(random(room_width), random(room_height), 0, OBJ_KorutiiniExample_EntityA);
    }
  
  
    // Objects are also supported iterables, it will iterate instances of given object.
    // Note, that this doesn't do any fail-safe if during iteration some instances are destroyed.
    PRINT "iterating over instances of 'obj_example_instance'.";
    FOREACH key, inst: value IN OBJ_KorutiiniExample_EntityA THEN
      KorutiiniExample_Log($"instance[{key}] = \{ x: {inst.x}, y: {inst.y} \};");
      DELAY 3 FRAMES
    END
    PRINT "done.";


  FINISH 
DISPATCH 













