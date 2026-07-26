

/**
* For dispatching crawlers in ordered manner.
* -> This shouldn't be used by the user!
*/ 
function __FolderCrawler_Dispatcher__Dispatch()
{
  // Get the context, hwhich holds global states.
  var _context = __FolderCrawler_Dispatcher__Context();
  
  
  // Check whether there is currently active crawler,
  // and whether it has already finished.
  if (_context.current != undefined)
  && (_context.current.IsFinished() == false)
  {
    return;
  }
  
  
  // Get next crawler.
  _context.current = ds_queue_dequeue(_context.pending);
  
  
  // If the is no active crawler, then there are no pending crawlers left.
  // -> Pause the timesource for dispatcher.
  if (_context.current == undefined)
  {
    time_source_pause(_context.timeSource);
    return;
  }
  
  
  // Otherwise activate the crawler.
  _context.current.Resume();
}
