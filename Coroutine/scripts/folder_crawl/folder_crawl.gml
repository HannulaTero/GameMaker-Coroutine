

/**
* Crawls through files and folders within given path.
* 
* ---
* 
* This will handle keeping only single crawler active, so there won't be many crawlers simultanously active. 
* The rest are kept in pending-queue, waiting for their turn.
* 
* ---
* 
* This is asynchronous / non-blocking, so crawling can be split into several frames.
* -> Crawler has time-budget how much it can try iterate, for example 0.75 -> 75% of the frame time.
* -> By default budget is high, assumes you are not really doing other stuff.
* 
* ---
* 
* Note, by default crawler will find all possible names within folder at once without stopping,
* because of file_find_* has global state..
* -> You may toggle "unsafe : true" to avoid this
* -> It will assume nothing elsewhere touches file_find_* while crawling
* -> This is done to avoid problems, if file_find_* function are used elsewhere.
* -> If single folder has lot of files/folders, this can cause stutter.
*
*/ 
function folder_crawl(_path, _descriptor=FolderCrawler_Descriptor())
{
  // Get the global context.
  var _context = __FolderCrawler_Dispatcher__Context();
  
  
  // (Re)Activate the timesource.
  // -> This will ensure the dispatcher is active.
  switch(time_source_get_state(_context.timeSource))
  {
    case time_source_state_initial: time_source_start(_context.timeSource); break;
    case time_source_state_stopped: time_source_start(_context.timeSource); break;
    case time_source_state_paused:  time_source_resume(_context.timeSource); break;
  }
  
  
  // Create crawler with given settings.
  // -> If no other is active, then it will start immediately.
  var _crawler = new FolderCrawler(_path, _descriptor);
  if (_context.current == undefined)
  {
    _context.current = _crawler;
  }
  else
  {
    // Push crawler into pending, 
    // dispatcher deals activating them whenever ready.
    ds_queue_enqueue(_context.pending, _crawler);
    _crawler.Pause();
  }
  return _crawler;
}

