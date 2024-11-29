/// @desc FOREACH. IN DS_LIST


COROUTINE
  ON_CLEANUP
    ds_list_destroy(list);

  BEGIN 
    // Initialize iterable structure.
    list = ds_list_create();
    ds_list_add(list, -1, -2, -3, -4);
    ds_list_add(list, +1, +2, +3, +4);
  
    // Do the iteration.
    // Behaves same as array, numberic key and value.
    PRINT "iterating over list.";
    FOREACH key, value IN list THEN
      show_debug_message($"list[| {key}] = {value};");
      DELAY 3 FRAMES
    END
    PRINT "done.";
  
  FINISH 
DISPATCH 













