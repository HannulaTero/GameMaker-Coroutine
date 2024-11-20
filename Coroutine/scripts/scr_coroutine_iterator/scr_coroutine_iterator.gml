


/// @func CoroutineIterator();
/// @desc Helper structure for iterating over iterable items in FOREACH.
/// feather ignore GM1041
function CoroutineIterator() constructor
{
  self.item = undefined;
  self.keys = undefined;
  self.index = 0;
  self.count = 0;
  self.nameVal = undefined;
  self.nameKey = undefined;
  self.GetVal = function(_scope) { };
  self.GetKey = function(_scope) { };
  
  
  /// @func Initialize(_item, _nameKey, _nameVal);
  /// @desc Howing initializer allows creation and initialization at different time.
  /// @param {Any} _item
  /// @param {String} _nameKey
  /// @param {String} _nameVal
  static Initialize = function(_item=undefined, _nameKey=undefined, _nameVal=undefined)
  {
    item = _item;
    nameKey = _nameKey;
    nameVal = _nameVal;
    
    switch(typeof(_item))
    {
      case "array": return asArray();
      case "struct": {
        if (is_instanceof(_item, CoroutineRange)) return asRange();
        if (is_instanceof(_item, CoroutineView)) return asView();
        return asStruct();
      }
      case "string": return asString();
      case "ref": {
        if (ds_exists(_item, ds_type_list)) return asList();
        if (ds_exists(_item, ds_type_map)) return asMap();
      }
      default: throw($"FOREACH: not iterable '{typeof(_item)}'");
      break;
    }
    
    return self;
  };
  
  
  /// @func Next(_scope);
  /// @desc Get the keys and values for next iteration.
  /// @param {Struct} _scope
  static Next = function(_scope)
  {
    if (nameVal != undefined) GetVal(_scope);
    if (nameKey != undefined) GetKey(_scope); 
    index++;
    return self;
  };
  
  
  /// @func Free();
  /// @desc Remove references.
  static Free = function()
  {
    self.item = undefined;
    self.keys = undefined;
    self.index = 0;
    self.count = 0;
    self.nameVal = undefined;
    self.nameKey = undefined;
    self.GetVal = undefined;
    self.GetKey = undefined;
    return self;
  };
  
  
  /// @func asArray();
  /// @desc Sets iterator state for array.
  static asArray = function()
  {
    self.count = array_length(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[index]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asStruct();
  /// @desc Sets iterator state for struct.
  static asStruct = function()
  {
    self.keys = struct_get_names(item);
    self.count = struct_names_count(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[$ keys[index]]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = keys[index]; };
    return self;
  };
  
  
  /// @func asRange();
  /// @desc Sets iterator state for range.
  static asRange = function()
  {
    self.start = item.start;
    self.count = floor((item.stop - item.start) / item.step);
    self.GetVal = function(_scope) { _scope[$ nameVal] = start + item.step * index; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
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
    self.GetVal = function(_scope) { _scope[$ nameVal] = buffer_peek(data, (start + item.step * index) * dsize, dtype); };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asString();
  /// @desc Sets iterator state for string.
  static asString = function()
  {
    self.index = 1; // In GML, strings are 1-indexed.
    self.count = string_length(item) + 1;
    self.GetVal = function(_scope) { _scope[$ nameVal] = string_char_at(item, index); };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asList();
  /// @desc Sets iterator state for ds_list.
  static asList = function()
  {
    self.count = ds_list_size(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[| index]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asMap();
  /// @desc Sets iterator state for ds_map.
  static asMap = function()
  {
    self.keys = ds_map_keys_to_array(item);
    self.count = ds_map_size(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[? keys[index]]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = keys[index]; };
    return self;
  };
}



















