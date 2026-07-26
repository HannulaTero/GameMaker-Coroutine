

/**
* User handle for the crawler.
* 
* ---
* 
* Read the descriptor for the possible optional arguments.
* 
*/ 
function FolderCrawler(_path, _descriptor=FolderCrawler_Descriptor()) constructor
{
  //=============================================================
  // 
  #region PUBLIC METHODS.
  
  
  
  // Debug methods, related, checking what crawler is currently doing.
  static DebugCount         = __FolderCrawler__DebugCount;
  static DebugCountFiles    = __FolderCrawler__DebugCountFiles;
  static DebugCountFolders  = __FolderCrawler__DebugCountFolders;
  static DebugFolder        = __FolderCrawler__DebugFolder;
  static DebugNext          = __FolderCrawler__DebugNext;
  static DebugPath          = __FolderCrawler__DebugPath;
  static DebugTime          = __FolderCrawler__DebugTime;
  
  
  // The usual methods.
  static GetRoot        = __FolderCrawler__GetRoot;
  static GetStatus      = __FolderCrawler__GetStatus;
  static GetStatusName  = __FolderCrawler__GetStatusName;
  static IsFinished     = __FolderCrawler__IsFinished;
  static IsPaused       = __FolderCrawler__IsPaused;
  static Pause          = __FolderCrawler__Pause;
  static Resume         = __FolderCrawler__Resume;
  static Stop           = __FolderCrawler__Stop;  
  
  
  
  #endregion
  // 
  //=============================================================
  // 
  #region PRIVATE VARIABLES.
  
  
  
  // Who has initialized the crawler.
  // @ignore
  self.initializer = other;
  
  
  // The root folder, where the crawling began.
  // @ignore
  self.root = new FolderCrawler_Folder(
    undefined, __FolderCrawler_GetName(_path), _path
  );
  
  
  // The structurewhich handles crawling.
  // @ignore
  self.iterator = new __FolderCrawler_Iterator(
    self, _descriptor
  );
  
  
  
  #endregion
  // 
  //=============================================================
}

