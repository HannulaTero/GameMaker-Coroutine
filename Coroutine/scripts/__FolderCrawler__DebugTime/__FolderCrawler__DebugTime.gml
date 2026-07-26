

/**
* Returns how many much time crawling has taken.
* Time updates up until crawling has finished.
* Returns in microseconds.
* 
* @context FolderCrawler
* @returns {Real}
*/ 
function __FolderCrawler__DebugTime()
{
  return self.iterator.debugTimeTaken;
}
