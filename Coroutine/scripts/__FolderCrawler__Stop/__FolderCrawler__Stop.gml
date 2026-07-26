

/**
* Stops crawler, can't be reactivated.
* This will do the callback with "failure" status by default, 
* as it has stopped early.
* 
* @context FolderCrawler
* @param {Enum.FolderCrawler_Status} _status
*/
function __FolderCrawler__Stop(_state=FolderCrawler_Status.FAILURE)
{
  self.iterator.Finish(_state);
}