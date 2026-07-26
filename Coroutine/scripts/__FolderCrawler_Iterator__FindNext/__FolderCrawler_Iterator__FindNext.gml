

/**
* Updates the content of nextName.
* 
* @context __FolderCrawler_Iterator
*/ 
function __FolderCrawler_Iterator__FindNext()
{
  self.nextName = array_pop(self.pendingNames) ?? "";
}
