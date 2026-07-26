

/**
* Applies given parameters to the crawler.
* 
* @context __FolderCrawler_Iterator
*/ 
function __FolderCrawler_Iterator__Config(_descriptor=FolderCrawler_Descriptor())
{
  // Get parameters, use defaults or from descriptor.
  var _params = FolderCrawler_Descriptor();
  with _params struct_foreach(_descriptor, function(_key, _item)
  {
    self[$ _key] = _item;
  });
  
  
  // Push the starting folder to boot up the iteration loop.
  array_push(self.folderStack, self.handle.root);
  
  
  // Context for the actions.
  self.userContext = _params.context;
  
  
  // Relative time budget, it is depend of how long frame is.
  self.budget = _params.budget;
  
  
  // Define mask.
  self.mask = ("\\" + _params.mask);
  
  
  // Define attributes.
  self.attributes = _params.attributes;
  
  
  // Whether start in paused state.
  if (_params.paused == true)
  {
    time_source_pause(self.timeSource);
  }
  
  
  // Define the iterator finder actions.
  if (_params.unsafe == true)
  {
    self.FindBegin  = __FolderCrawler_Iterator__FindUnsafeBegin;
    self.FindClose  = __FolderCrawler_Iterator__FindUnsafeClose;
    self.FindNext   = __FolderCrawler_Iterator__FindUnsafeNext;
  }
  
  
  // Define the actions.
  var _other = self.handle.initializer;
  self.ActionInit   = __FolderCrawler_Rescope(_other, _descriptor, _params.init);
  self.ActionOpen   = __FolderCrawler_Rescope(_other, _descriptor, _params.open);
  self.ActionFile   = __FolderCrawler_Rescope(_other, _descriptor, _params.file);
  self.ActionFolder = __FolderCrawler_Rescope(_other, _descriptor, _params.folder);
  self.Callback     = __FolderCrawler_Rescope(_other, _descriptor, _params.callback);

  
  // Do the initialization call.
  self.ActionInit(self.folderCurrent, self.userContext);
}


