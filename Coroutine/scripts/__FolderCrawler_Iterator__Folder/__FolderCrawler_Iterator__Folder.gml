

/**
* Adds given name as folder to the current folder, 
* but only if it is a folder - this is decided whether it can be found in files. 
* 
* @context __FolderCrawler_Iterator
* @param {String} _name
*/ 
function __FolderCrawler_Iterator__Folder(_name)
{
  // Check whether it is a file.
  if (ds_map_exists(self.fileMapping, _name) == true)
  {
    return;
  }
  
  // Skip .git -folder.
  if (_name == ".git")
  {
    return;
  }
  
  // Otherwise create new folder for given path.
  var _path = (self.folderCurrent.path + "\\" + _name);
  var _folder = new FolderCrawler_Folder(self.folderCurrent, _name, _path);
  self.ActionFolder(_folder, self.userContext);
  self.debugCountFolders += 1;
  
  // Add into the folders of current folder.
  self.folderCurrent.folders[$ _name] = _folder;
  
  // Add into stack of upcoming iteration targets.
  array_push(self.folderStack, _folder);
}

