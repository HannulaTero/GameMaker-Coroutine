

/**
* Updates the content of nextName.
* 
* @context __FolderCrawler_Iterator
*/ 
function __FolderCrawler_Iterator__FindUnsafeNext()
{
  self.nextName = file_find_next();
}