

/**
* Returns next name, which will be checked next in current given path.
* -> In practice this only appears whenever using unsafe crawling.
* 
* @context FolderCrawler
* @returns {String}
*/ 
function __FolderCrawler__DebugNext()
{
  return self.iterator.nextName;
}
