

/**
* Makes crawling finish with given status, by default finishes with success.
* Stops crawler, can't be reactivated.
* 
* @context __FolderCrawler_Iterator
* @param {Enum.FolderCrawler_Status} _status
*/
function __FolderCrawler_Iterator__Finish(_status=FolderCrawler_Status.SUCCESS)
{
  // Destroy datastructures.
  time_source_destroy(self.timeSource);
  ds_map_destroy(self.fileMapping);
  
  // Update the variables.
  self.status         = _status;
  self.timeSource     = undefined;
  self.debugTimeTaken = (get_timer() - self.debugTimeBegin);
  
  // Call the final callback.
  self.Callback(self.handle, self.userContext);
}

