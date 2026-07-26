

/**
* Handles crawling state and recursively iterating through folders and files.
* 
* ---
* 
* Read the descriptor for the possible arguments.
* 
* @param {Struct.FolderCrawler} _handle
*/ 
function __FolderCrawler_Iterator(_handle, _descriptor=FolderCrawler_Descriptor()) constructor
{
  //=============================================================
  // 
  #region STATIC METHODS.
  
  
  
  static Finish = __FolderCrawler_Iterator__Finish;
  
  
  
  #endregion
  // 
  //=============================================================
  // 
  #region METHODS.
  
  
  
  // What action is being taken in iteration (folder or file)
  self.AddItem = undefined;
  
  
  // When starting iterating through mask+attributes, updates nextName
  self.FindBegin  = __FolderCrawler_Iterator__FindBegin;
  
  
  // Closest the name iteration.
  self.FindClose  = __FolderCrawler_Iterator__FindClose;
  
  
  // Updates nextName with next name, or if not found, updates as ""
  self.FindNext   = __FolderCrawler_Iterator__FindNext;
  
  
  // What is the action when crawling is initialized.
  self.ActionInit = __FolderCrawler__DefaultActionInit;
  
  
  // What is the action when folder is opened.
  self.ActionOpen = __FolderCrawler__DefaultActionOpen;
  
  
  // What is the action for folders while crawling.
  self.ActionFolder = __FolderCrawler__DefaultActionFolder;
  
  
  // What is the action for files while crawling.
  self.ActionFile = __FolderCrawler__DefaultActionFile;
  
  
  // Called when crawling finished / stops.
  self.Callback = __FolderCrawler__DefaultCallback;
  
  
  
  #endregion
  // 
  //=============================================================
  // 
  #region VARIABLES.
  
  
  
  // The FolderCrawler handle which owns the iterator.
  // @ignore
  self.handle = _handle;
  
  
  // Select the crawling method and create iterator.
  // Timesource does the iteration loop.
  self.timeSource = time_source_create(
    time_source_global, 1, time_source_units_frames,
    method(self, __FolderCrawler_Iterator__Loop), [ ], -1
  );
  time_source_start(self.timeSource);
  

  // Holds pending folder paths, which will be crawled.
  self.folderStack = [ ];
  

  // The currently active folder, which is being iterated through.
  self.folderCurrent = undefined;
  
  
  // File and folder names of the currently active folder.
  // -> Used for the "safe" iterations.
  self.pendingNames = [ ];
  
  
  // Next name in "unsafe" iteration.
  self.nextName = "";
  
  
  // What files have been found.
  // -> This is used to find folders.
  self.fileMapping = ds_map_create();
  
  
  // How many folders have been found.
  self.debugCountFolders = 0;
  
  
  // How many files have been found.
  self.debugCountFiles = 0;
  
  
  // The reference time when crawling started.
  self.debugTimeBegin = get_timer();
  
  
  // How much time crawling has taken.
  self.debugTimeTaken = 0;
  
  
  // Context, which is passed to the actions.
  self.userContext = undefined; 
  
  
  // What is the crawling status.
  self.status = FolderCrawler_Status.PENDING;
  
  
  // How much time can be used at one frame.
  self.budget = 0.95;
  
  
  // What is the search mask.
  self.mask = "\\*";
  
  
  // What attributes are used while searching.
  self.attributes = fa_none;
  
  
  // Define the variables.
  __FolderCrawler_Iterator__Config(_descriptor);
  
  
  
  #endregion
  // 
  //=============================================================
}