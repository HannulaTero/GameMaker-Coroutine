

/**
* The descriptor signature for the crawler.
* 
* ---
* 
* This defines possible arguments for the crawler,
* and their expected types as default values.
*/ 
function FolderCrawler_Descriptor()
{
  return {
    mask        : "*",
    unsafe      : false,
    paused      : false,
    context     : undefined,
    budget      : 0.925,
    attributes  : fa_none,
    init        : __FolderCrawler__DefaultActionInit,
    open        : __FolderCrawler__DefaultActionOpen,
    file        : __FolderCrawler__DefaultActionFile,
    folder      : __FolderCrawler__DefaultActionFolder,
    callback    : __FolderCrawler__DefaultCallback,
  };
}