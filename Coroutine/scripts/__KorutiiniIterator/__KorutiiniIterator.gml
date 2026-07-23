


/**
* Helper structure for iterating over iterable items in FOREACH.
* 
* @param {Any}    _item
* @param {String} _nameKey
* @param {String} _nameVal
*/ 
function __KorutiiniIterator(_item=undefined, _nameKey=undefined, _nameVal=undefined) constructor
{
  // Static variables.
  static Next = __KorutiiniIterator__Next;
  
  
  // Variables.
  item    = _item;
  keys    = undefined;
  index   = 0;
  count   = 0;
  nameVal = _nameVal;
  nameKey = _nameKey;
  GetVal  = function() { };
  GetKey  = function() { };
  
  
  // Find correct methods for iterating the given item.
  switch(typeof(item))
  {
    case "array": {
      return __KorutiiniIterator__AsArray();
    }
    
    case "struct": {
      if (is_instanceof(item, __KorutiiniRange)) 
      {
        return __KorutiiniIterator__AsRange();
      }
      
      if (is_instanceof(item, __KorutiiniView)) 
      {
        return __KorutiiniIterator__AsView();
      }
      
      return __KorutiiniIterator__AsStruct();
    }
    
    case "ref": {
      if (ds_exists(item, ds_type_list)) 
      {
        return __KorutiiniIterator__AsList();
      }
      
      if (ds_exists(item, ds_type_map)) 
      {
        return __KorutiiniIterator__AsMap();
      }
      
      if (object_exists(item)) 
      {
        return __KorutiiniIterator__AsObject();
      }
      
      if (buffer_exists(item)) 
      {
        item = new __KorutiiniView(item, buffer_u8);
        return __KorutiiniIterator__AsView();
      }
    }
    
    case "string": {
      return __KorutiiniIterator__AsString();
    }
    
    case "number": 
    case "int64": 
    case "int32": { 
      item = new __KorutiiniRange(item);
      return __KorutiiniIterator__AsRange();
    }
    
    default: {
      throw($"FOREACH: not iterable '{typeof(item)}'");
      break;
    }
  }
}



















