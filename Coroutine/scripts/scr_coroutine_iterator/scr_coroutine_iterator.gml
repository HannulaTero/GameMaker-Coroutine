


/// @func CoroutineIterator(_item, _nameKey, _nameVal);
/// @desc Helper structure for iterating over iterable items in FOREACH.
/// @param {Any} _item
/// @param {String} _nameKey
/// @param {String} _nameVal
/// feather ignore GM1041
/// feather ignore GM1044
/// feather ignore GM1049
/// feather ignore GM2043
function CoroutineIterator(_item=undefined, _nameKey=undefined, _nameVal=undefined) constructor
{
  self.item = _item;
  self.keys = undefined;
  self.index = 0;
  self.count = 0;
  self.nameVal = _nameKey;
  self.nameKey = _nameVal;
  self.GetVal = function() {};
  self.GetKey = function() {};


  // Find correct methods for iterating the given item.
  switch(typeof(item))
  {
    case "array": return asArray();
    case "struct": {
      if (is_instanceof(item, CoroutineRange)) return asRange();
      if (is_instanceof(item, CoroutineView)) return asView();
      return asStruct();
    }
    case "ref": {
      if (ds_exists(item, ds_type_list)) return asList();
      if (ds_exists(item, ds_type_map)) return asMap();
      if (object_exists(item)) return asObject();
      if (buffer_exists(item)) {
        item = new CoroutineView(item, buffer_u8);
        return asView();
      }
    }
    case "string": return asString();
    case "number": 
    case "int64": 
    case "int32": { 
      item = new CoroutineRange(item);
      return asRange();
    }
    default: throw($"FOREACH: not iterable '{typeof(item)}'");
    break;
  }
  
  
  /// @func Next();
  /// @desc Get the keys and values for next iteration.
  static Next = function()
  {
    if (nameVal != undefined) GetVal();
    if (nameKey != undefined) GetKey(); 
    index++;
    return self;
  };
  
  
  /// @func asArray();
  /// @desc Sets iterator state for array.
  static asArray = function()
  {
    self.count = array_length(item);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = item[index]; };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asStruct();
  /// @desc Sets iterator state for struct.
  static asStruct = function()
  {
    self.keys = struct_get_names(item);
    self.count = struct_names_count(item);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = item[$ keys[index]]; };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = keys[index]; };
    return self;
  };
  
  
  /// @func asObject();
  /// @desc Sets iterator state for object.
  static asObject = function()
  {
    var _index = 0;
    var _object = item;
    var _instances = array_create(instance_number(item));
    with(_object) _instances[_index++] = self;
    
    self.item = _instances;
    self.count = array_length(item);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = item[index]; };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asRange();
  /// @desc Sets iterator state for range.
  static asRange = function()
  {
    self.start = item.start;
    self.count = floor((item.stop - item.start) / item.step);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = start + item.step * index; };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asView();
  /// @desc Sets iterator state for buffer in specific view.
  static asView = function()
  {
    self.data = item.data;
    self.dtype = item.dtype;
    self.dsize = item.dsize;
    self.count = floor((item.stop - item.start) / item.step);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = buffer_peek(data, (start + item.step * index) * dsize, dtype); };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asString();
  /// @desc Sets iterator state for string.
  static asString = function()
  {
    self.index = 1; // In GML, strings are 1-indexed.
    self.count = string_length(item) + 1;
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = string_char_at(item, index); };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asList();
  /// @desc Sets iterator state for ds_list.
  static asList = function()
  {
    self.count = ds_list_size(item);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = item[| index]; };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asMap();
  /// @desc Sets iterator state for ds_map.
  static asMap = function()
  {
    self.keys = ds_map_keys_to_array(item);
    self.count = ds_map_size(item);
    self.GetVal = function() { COROUTINE_SCOPE[$ nameVal] = item[? keys[index]]; };
    self.GetKey = function() { COROUTINE_SCOPE[$ nameKey] = keys[index]; };
    return self;
  };
}



















