

/**
* Pauses active crawling, which can be resumed later.
* 
* @context FolderCrawler
*/
function __FolderCrawler__Pause()
{
  if (self.IsFinished() == true)
  {
    return;
  }
    
  time_source_pause(self.iterator.timeSource);
}