

/**
* Return the crawling status as a string.
* 
* @context FolderCrawler
* @returns {String}
*/ 
function __FolderCrawler__GetStatusName()
{
  switch(self.iterator.status)
  {
    case FolderCrawler_Status.PENDING : return "pending";
    case FolderCrawler_Status.SUCCESS : return "success";
    case FolderCrawler_Status.FAILURE : return "failure";
    default : return "error";
  }
}
