

/**
* Returns what path is being currently crawled.
* 
* @context FolderCrawler
* @returns {String}
*/ 
function __FolderCrawler__DebugPath()
{
  var _curr = self.iterator.folderCurrent;
  return (_curr != undefined) ? _curr.path : "";
}
