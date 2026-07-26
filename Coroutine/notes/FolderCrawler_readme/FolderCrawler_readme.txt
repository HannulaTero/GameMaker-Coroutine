---


# FOLDER CRAWLER
v1.1.2, by Tero Hannula

Tested on GameMaker LTS2026 Version
- IDE v2026.0.0.16
- Runtime v2026.0.0.23
- GMRT 0.19

---


**This asset can be used to crawl out larger folder/file-structures
without making the game to freeze up by splitting crawling into several frames.**

Crawling will result nested stucture containing structs, which represent files and folders.


Use `folder_crawl(path, params)` to dispatch crawler(s).
This will queue up the requests, so only single of them is active at given time. 
This is done to avoid concurrent uses of `file_find_*` (which is important with "unsafe" crawl)
but also makes frame-budgeting simpler.


---


Note that sandboxing can affect where can be crawled, so check the project sandbox settings.
Also note platform related restrictions (HTML5 and GX for example).

As `file_find_*` has global state, asset avoids spreading its use over several frame, 
therefore it collects all names within folder at once, 
and then creates structure and pushes next folders for dispatching. 
This does mean there is possiblity that folder just contains so many files/folders, that game still freezes. 
This could be avoided, if also use of `file_find_*` is spread over several frames.


---


By default, the resulting structure is build from following structs :

```
file : {
  root : Struct   ---   Which folders contains the file.
  type : String   ---   "file".
  name : String   ---   Name of the file.
  path : String   ---   Absolute path for the file, includes name.
}
  
folder : {
  root    : Struct  ---   Which folders contains the folder.
  type    : String  ---   "folder".
  name    : String  ---   Name of the folder.
  path    : String  ---   Absolute path for the folder, includes name.
  files   : Array   ---   Contains file-structs, which belong to the folder.
  folders : Array   ---   Contains folder-structs, which belong to the folder.
}
```

---
  
  
The acceptable parameters can be seen from Descriptor-signature.
Descriptor accepts user-defined actions and callback as methods.
=> The method signatures can also be found in signature-folder.
  

---


The names are separated with `"_"` like FolderCrawler_File
Private scripts are marked with double underscore `"__"`.

Methods are put into separate files in this asset.
* First prefix with double underscore `"__"`
* secondly construct name like `"FolderCrawler"`
* Thirdly infix with double underscore `"__"`
* Finally method name, like `"IsFinished"`
* This means crawler method `"IsFinished"` is in file `"__FolderCrawler__IsFinished"`


---