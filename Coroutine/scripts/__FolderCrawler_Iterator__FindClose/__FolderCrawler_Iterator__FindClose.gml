

/**
* Clears the pending names array.
* 
* @context __FolderCrawler_Iterator
*/ 
function __FolderCrawler_Iterator__FindClose()
{
  array_resize(self.pendingNames, 0);
}
