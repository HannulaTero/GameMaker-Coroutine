

/// @func CoroutineView(_data);
/// @desc Creates iterable buffer view (buffer, dtype, start, stop, step)
function CoroutineView() constructor
{
  // Declare variables.
  self.data = undefined;
  self.dtype = undefined;
  self.dsize = undefined;
  self.start = 0;
  self.stop = 0;
  self.step = 1;
  
  
  // Single argument.
  switch(argument_count)
  {
    // Either only buffer is set, or parameters are given as struct.
    case 1:
    {
      var _item = argument[0];
      if (is_struct(_item))
      {
        self.data = _item[$ "data"];
        self.dtype = _item[$ "dtype"] ?? buffer_u8;
        self.dsize = buffer_sizeof(dtype);
        self.start = _item[$ "start"] ?? start;
        self.stop = _item[$ "stop"] ?? stop;
        self.step = _item[$ "step"] ?? step;
      }
      else
      {
        self.data = _item;
        self.dtype = buffer_u8;
        self.dsize = buffer_sizeof(dtype);
        self.start = 0;
        self.stop = buffer_get_size(data) / dsize;
        self.step = 1;
      }
      break;
    }
  
    // Data and dtype are set.
    case 2:
    {
      self.data = argument[0];
      self.dtype = argument[1];
      self.dsize = buffer_sizeof(dtype);
      self.start = 0;
      self.stop = buffer_get_size(data) / dsize;
      self.step = 1;
      break;
    }
  
    // Data, dtype and length are set.
    case 3:
    {
      self.data = argument[0];
      self.dtype = argument[1];
      self.dsize = buffer_sizeof(dtype);
      self.start = 0;
      self.stop = argument[2];
      self.step = 1;
      break;
    }
  
    // Data, dtype, offset and length are set.
    case 4:
    {
      self.data = argument[0];
      self.dtype = argument[1];
      self.dsize = buffer_sizeof(dtype);
      self.start = argument[2];
      self.stop = argument[3];
      self.step = 1;
      break;
    }
  
    // All are set (data, dtype, start, stop, step)
    case 5:
    {
      self.data = argument[0];
      self.dtype = argument[1];
      self.dsize = buffer_sizeof(dtype);
      self.start = argument[2];
      self.stop = argument[3];
      self.step = argument[4];
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



