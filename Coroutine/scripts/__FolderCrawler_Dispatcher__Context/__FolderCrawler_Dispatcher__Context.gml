

/**
* Returns the global context used internally for dispatcher.
* -> This shouldn't be used by the user!
*/ 
function __FolderCrawler_Dispatcher__Context()
{
  static context = {
    // Currently active crawler.
    current : undefined,
    
    // The queue of awaiting crawlers.
    pending : ds_queue_create(),
    
    // The dispatcher loop, handles dequeueing next crawler.
    timeSource : time_source_create(
      time_source_global, 1, time_source_units_frames,
      __FolderCrawler_Dispatcher__Dispatch, [ ], -1
    )
  };
  
  return context;
}
