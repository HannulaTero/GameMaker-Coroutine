

/// @func CoroutineView(_data);
/// @desc Creates iterable buffer view (buffer, dtype, start, stop, step)
function CoroutineView() constructor
{
  // Declare variables.
  data = undefined;
  dtype = undefined;
  dsize = undefined;
  start = 0;
  stop = 0;
  step = 1;
  
  
  switch(argument_count)
  {
    // Either only buffer is set, or parameters are given as struct.
    case 1:
    {
      var _item = argument[0];
      if (is_struct(_item))
      {
        data = _item[$ "data"];
        dtype = _item[$ "dtype"] ?? buffer_u8;
        dsize = buffer_sizeof(dtype);
        start = _item[$ "start"] ?? start;
        stop = _item[$ "stop"] ?? stop;
        step = _item[$ "step"] ?? step;
      }
      else
      {
        data = _item;
        dtype = buffer_u8;
        dsize = buffer_sizeof(dtype);
        start = 0;
        stop = buffer_get_size(data) / dsize;
        step = 1;
      }
      break;
    }
  
    // Data and dtype are set.
    case 2:
    {
      data = argument[0];
      dtype = argument[1];
      dsize = buffer_sizeof(dtype);
      start = 0;
      stop = buffer_get_size(data) / dsize;
      step = 1;
      break;
    }
  
    // Data, dtype and length are set.
    case 3:
    {
      data = argument[0];
      dtype = argument[1];
      dsize = buffer_sizeof(dtype);
      start = 0;
      stop = argument[2];
      step = 1;
      break;
    }
  
    // Data, dtype, offset and length are set.
    case 4:
    {
      data = argument[0];
      dtype = argument[1];
      dsize = buffer_sizeof(dtype);
      start = argument[2];
      stop = argument[3];
      step = 1;
      break;
    }
  
    // All are set (data, dtype, start, stop, step)
    case 5:
    {
      data = argument[0];
      dtype = argument[1];
      dsize = buffer_sizeof(dtype);
      start = argument[2];
      stop = argument[3];
      step = argument[4];
      break;
    }
  
    // Not acceptable.
    default:
    {
      throw("VIEW has invalid amount of arguments.");
      break;
    }
  }
  
  // Sanity check.
  if (step == 0)
  {
    throw("VIEW step-size must not be zero.");
  }
}



