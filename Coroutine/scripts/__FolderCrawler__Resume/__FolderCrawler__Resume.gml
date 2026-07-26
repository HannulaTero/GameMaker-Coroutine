

/**
* If crawler has been paused, then resume execution.
* 
* @context FolderCrawler
*/ 
function __FolderCrawler__Resume()
{
  if (self.IsFinished() == true)
  {
    return;
  }
  
  time_source_resume(self.iterator.timeSource);
}
