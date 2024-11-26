/*

if (keyboard_check_pressed(vk_anykey))
{
  var _example = undefined;
  switch(keyboard_string)
  {
    case "1": _example = obj_example_basics_00_hello_world; break;
    case "2": _example = obj_example_basics_01_scope; break;
    case "3": _example = obj_example_basics_02_settings; break;
    case "4": _example = obj_example_basics_03_prototype; break;
    case "5": _example = obj_example_basics_04_dispatch; break;
    case "6": _example = obj_example_basics_05_variables; break;
    case "7": _example = obj_example_async_request_00_get_string; break;
    case "8": _example = obj_example_async_request_01_get_integers; break;
    case "9": _example = obj_example_async_request_02_http_get; break;
  }
  
  keyboard_string = "";
  if (_example != undefined)
  {
    instance_destroy(obj_example_base);
    instance_create_depth(0, 0, 0, _example);
  }
}
 