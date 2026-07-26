

/**
* Returns generated korutiini-entrypoint for given file&line.
* 
* @param {String} _file The string from _GMFILE_
* @param {Real}   _line The real from _GMLINE_
* @returns {Function | Undefined} 
*/ 
function __KorutiiniSugar_GetEntrypoint(_file, _line)
{
  // Builder-generated entrypoints.
  static entrypoints = __KorutiiniSugar_GENERATED();
  
  
  // Get the key - Expects only one coroutine in the line.
  // -> Technically this could be issue, but in practice shouldn't be.
  // -> The _GMFUNCTION_ could identify exactly, 
  //    but creating correct key with builder would be cumbersome.
  var _key = $"{_file}@{_line}";
  
  
  // Check whether finds generated entrypoint.
  // -> If doesn't, macros should handle returning original function.
  var _entrypoint = entrypoints[$ _key];
  if (_entrypoint == undefined)
  {
    throw($"[Korutiini][Sugar] Couldn't find korutiini : {_key}");
    return undefined; 
  }
  
  
  // Return the entrypoint.
  return _entrypoint;
}



