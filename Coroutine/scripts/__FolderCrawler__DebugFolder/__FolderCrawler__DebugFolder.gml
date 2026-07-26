

/**
* Returns currently active folder, which us being crawled.
* 
* @context FolderCrawler
* @returns {Struct.FolderCrawler_Folder}
*/ 
function __FolderCrawler__DebugFolder()
{
  return self.iterator.folderCurrent;
}
