


/// @func CoroutineForeachIterator();
/// @desc 
/// feather ignore GM1041
function CoroutineForeachIterator() constructor
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
  /// @desc 
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
      case "struct": return asStruct();
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
  /// @desc 
  /// @param {Struct} _scope
  static Next = function(_scope)
  {
    if (nameVal != undefined) GetVal(_scope);
    if (nameKey != undefined) GetKey(_scope); 
    index++;
    return self;
  };
  
  
  /// @func Free();
  /// @desc 
  static Free = function()
  {
    self.item = undefined;
    self.keys = undefined;
    self.index = 0;
    self.count = 0;
    return self;
  };
  
  
  /// @func asArray();
  /// @desc 
  static asArray = function()
  {
    self.count = array_length(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[index]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asStruct();
  /// @desc 
  static asStruct = function()
  {
    self.keys = struct_get_names(item);
    self.count = struct_names_count(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[$ keys[index]]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = keys[index]; };
    return self;
  };
  
  
  /// @func asString();
  /// @desc 
  static asString = function()
  {
    self.index = 1; // In GML, strings are 1-indexed.
    self.count = string_length(item) + 1;
    self.GetVal = function(_scope) { _scope[$ nameVal] = string_char_at(item, index); };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asList();
  /// @desc 
  static asList = function()
  {
    self.count = ds_list_size(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[| index]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = index; };
    return self;
  };
  
  
  /// @func asMap();
  /// @desc 
  static asMap = function()
  {
    self.keys = ds_map_keys_to_array(item);
    self.count = ds_map_size(item);
    self.GetVal = function(_scope) { _scope[$ nameVal] = item[? keys[index]]; };
    self.GetKey = function(_scope) { _scope[$ nameKey] = keys[index]; };
    return self;
  };
}



















