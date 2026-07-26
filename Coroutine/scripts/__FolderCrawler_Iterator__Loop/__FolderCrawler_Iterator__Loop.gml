

/**
* Crawls through folders and files, quits whenever time budget is spent.
* Should not be called by the user. The timesource should handle this.
* 
* ---
* 
* This is the main crawler-loop.
* 
* ---
* 
* The file_find_* are abstracted to own functions, so the underlying implementation can be changed. 
* -> Splitting use of "file_find_*" into several frames is "unsafe"
* -> The safe mode searches all names within folder at once, which can cause stutter with wide folders.
* 
* ---
* 
* "directory_exists" -function is SLOW
* -> This implementation tries to avoid using it by iterating twice.
* -> file_find_next is also slow, but iterating twice is still faster.
* 
* ---
* 
* In GM you can't iterate through only folders. So this is done in two passes:
* -> First, find only target files. (add to map)
* -> Second, find these files + folders. (check whether on map)
* 
* @context __FolderCrawler_Iterator
*/ 
function __FolderCrawler_Iterator__Loop()
{
  // Get the time budget.
  var _timeCurrent  = get_timer();
  var _timeSpeed    = game_get_speed(gamespeed_microseconds);
  var _timeBudget   = (self.budget * _timeSpeed);
  var _timeTarget   = (_timeCurrent + _timeBudget);
  self.debugTimeTaken = (_timeCurrent - self.debugTimeBegin);
  
  
  // Iterate until frame-budget has been exhausted.
  while(get_timer() < _timeTarget)
  {
    // Add items until no new item names, or time is up.
    while(self.nextName != "")
    {
      if (get_timer() >= _timeTarget) return;
      self.AddItem(self.nextName);
      self.FindNext();
    }
    
    
    // Close current folder iteration.
    self.FindClose();
    
    
    // Check whether was iterating through files.
    // -> If yes, then swap to iterating through the folders.
    // -> Previously iterated through only the files.
    // -> Now iterating through both (in GM can't iterate only folders).
    if (self.AddItem == __FolderCrawler_Iterator__File)
    {
      self.AddItem = __FolderCrawler_Iterator__Folder;
      self.FindBegin(
        (self.folderCurrent.path + "\\*"), 
        (self.attributes | fa_directory)
      );
      continue;
    }
    
    
    // Pop next iteration target.
    // -> This will be next name-iterations target.
    self.folderCurrent = array_pop(self.folderStack);
    
    
    // Check if no more items left -> end the loop.
    if (self.folderCurrent == undefined)
    {
      self.Finish();
      return;
    }
    
    
    // Call action that next folder is being opened.
    self.ActionOpen(self.folderCurrent, self.userContext);
    
    
    // Start iterating through the files.
    // -> This excludes the folders.
    ds_map_clear(self.fileMapping);
    self.AddItem = __FolderCrawler_Iterator__File;
    self.FindBegin(
      (self.folderCurrent.path + self.mask), 
      (self.attributes & (~fa_directory))
    );
  }
}