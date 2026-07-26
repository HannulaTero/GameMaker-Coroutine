
/**
* Tells the crawler state.
* Error should never appear, expect if something has gone horribly wrong.
*/ 
enum FolderCrawler_Status
{
  ERROR,
  PENDING,
  SUCCESS,
  FAILURE,
  length
};