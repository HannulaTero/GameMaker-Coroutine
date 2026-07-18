


/**
* Helper structure for iterating over iterable items in FOREACH.
* 
* @param {Any}    _item
* @param {String} _nameKey
* @param {String} _nameVal
*/ 
function __CoroutineIterator(_item=undefined, _nameKey=undefined, _nameVal=undefined) constructor
{
  // Static variables.
  static Next = __CoroutineIterator__Next;
  
  
  // Variables.
  item    = _item;
  keys    = undefined;
  index   = 0;
  count   = 0;
  nameVal = _nameVal;
  nameKey = _nameKey;
  GetVal  = function() {};
  GetKey  = function() {};
  
  
  // Find correct methods for iterating the given item.
  switch(typeof(item))
  {
    case "array": {
      return __CoroutineIterator__AsArray();
    }
    
    case "struct": {
      if (is_instanceof(item, __CoroutineRange)) 
      {
        return __CoroutineIterator__AsRange();
      }
      if (is_instanceof(item, __CoroutineView)) 
      {
        return __CoroutineIterator__AsView();
      }
      return __CoroutineIterator__AsStruct();
    }
    
    case "ref": {
      if (ds_exists(item, ds_type_list)) 
      {
        return __CoroutineIterator__AsList();
      }
      if (ds_exists(item, ds_type_map)) 
      {
        return __CoroutineIterator__AsMap();
      }
      if (object_exists(item)) 
      {
        return __CoroutineIterator__AsObject();
      }
      if (buffer_exists(item)) 
      {
        item = new __CoroutineView(item, buffer_u8);
        return __CoroutineIterator__AsView();
      }
    }
    
    case "string": {
      return __CoroutineIterator__AsString();
    }
    
    case "number": 
    case "int64": 
    case "int32": { 
      item = new __CoroutineRange(item);
      return __CoroutineIterator__AsRange();
    }
    
    default: {
      throw($"FOREACH: not iterable '{typeof(item)}'");
      break;
    }
  }
}



















