

/**
* Helper function to deal with method scopes from descriptor.
* Assumes the method shouldn't be bound to descriptor struct.
* 
* @param {Struct | Id.Instance} _other
* @param {Struct}               _descriptor
* @param {Function}             _Action
*/
function __FolderCrawler_Rescope(_other, _descriptor, _Action)
{
  if (is_method(_Action) == false)
  || (method_get_self(_Action) == _descriptor)
  {
    _Action = method(_other, _Action);
  }
  
  return _Action;
}