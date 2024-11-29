/// @desc FOREACH IN DS_MAP.


COROUTINE
  ON_CLEANUP
    ds_map_destroy(map);

  BEGIN 
    // Initializing iterable datastructure.
    map = ds_map_create();
    ds_map_add(map, "apple", 200);
    ds_map_add(map, "orange", 400);
    ds_map_add(map, "kiwi", 600);
    ds_map_add(map, "grape fruit", 550);

    // Iterating keys be renamed, which can make things more readable or not.
    // iterating over ds_map is similar to struct, but keys can be non-string.
    PRINT "iterating over ds_map.";
    FOREACH fruit: key, cost: value IN map THEN
      show_debug_message($"map[? {fruit}] = {cost};");
      DELAY 3 FRAMES
    END
    PRINT "done.";

  FINISH 
DISPATCH 













