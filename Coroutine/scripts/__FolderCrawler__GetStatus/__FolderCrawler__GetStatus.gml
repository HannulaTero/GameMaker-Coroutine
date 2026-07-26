

/**
* Return the crawling status.
* 
* @context FolderCrawler
* @returns {Enum.FolderCrawler_Status}
*/ 
function __FolderCrawler__GetStatus()
{
  return self.iterator.status;
}

