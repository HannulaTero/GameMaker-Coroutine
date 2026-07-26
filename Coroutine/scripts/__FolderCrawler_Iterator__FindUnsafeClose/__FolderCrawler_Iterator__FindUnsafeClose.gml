

/**
* Closes file_find_*, so it is safe to use elsewhere again.
* 
* @context __FolderCrawler_Iterator
*/ 
function __FolderCrawler_Iterator__FindUnsafeClose() 
{
  file_find_close();
}