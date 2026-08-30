

// Initialize globals.
KORUTIINI_CURRENT_TASK      = undefined;
KORUTIINI_CURRENT_EXECUTE   = undefined;
KORUTIINI_CURRENT_LOCAL     = undefined;
KORUTIINI_CURRENT_SCOPE     = undefined;
KORUTIINI_CURRENT_YIELDED   = false;


// As Manager and Timer as instances, 
// they are suspectible for instance_destroy(all) etc.
// Timer ensures they will be reactiveated or recreated.
call_later(
  1, time_source_units_frames, function()
  {
    // Try activating them first.
    if (instance_exists(__OBJ_Korutiini_Manager) == false)
    {
      instance_activate_object(__OBJ_Korutiini_Manager);
    }
    
    if (instance_exists(__OBJ_Korutiini_Timer) == false)
    {
      instance_activate_object(__OBJ_Korutiini_Timer);
    }
    
      
    // If activation failed, recreate them.
    if (instance_exists(__OBJ_Korutiini_Manager) == false)
    {
      instance_create_depth(0, 0, 0, __OBJ_Korutiini_Manager);
    }
    
    if (instance_exists(__OBJ_Korutiini_Timer) == false)
    {
      instance_create_depth(0, 0, 0, __OBJ_Korutiini_Timer);
    }
    
  }, true
);

