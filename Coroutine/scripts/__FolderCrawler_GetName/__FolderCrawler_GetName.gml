

/**
* Returns name of the given folder or file.
*/
function __FolderCrawler_GetName(_path)
{
  var _length = string_length(_path);
  var _char   = string_char_at(_path, _length);
  
  
  // Check whether ending in slash.
  if ((_char == "\\") || (_char == "/"))
  {
    _path = string_delete(_path, _length, 1);
  }
  
  
  // Return the filename.
  return filename_name(_path);
}