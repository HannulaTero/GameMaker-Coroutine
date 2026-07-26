


/**
* Uses file_find_* functions safely, finds all names at once.
* 
* ---
* 
* Iterate through the current path items.
* -> Done in single step because file-finding has global state.
* -> After all names have been found, loop will return back.
* 
* @context __FolderCrawler_Iterator
* @param {String}                 _mask
* @param {Constant.FileAttribute} _attr
*/ 
function __FolderCrawler_Iterator__FindBegin(_mask, _attr)
{
  // Find all items in single go.
  var _name = file_find_first(_mask, _attr);
  while(_name != "")
  {
    array_push(self.pendingNames, _name);
    _name = file_find_next();
  }
  file_find_close();
  
  
  // Get the first item.
  __FolderCrawler_Iterator__FindNext();
}
