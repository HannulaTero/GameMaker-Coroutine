

/**
* Returns how many files and folders have been crawled through.
* 
* @context FolderCrawler
* @returns {Real}
*/ 
function __FolderCrawler__DebugCount()
{
  return (
    + self.iterator.debugCountFiles
    + self.iterator.debugCountFolders
  )
}
