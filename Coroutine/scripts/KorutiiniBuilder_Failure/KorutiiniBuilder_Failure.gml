

/**
* Fails and stops the builder.
*/ 
function KorutiiniBuilder_Failure(_message)
{
  show_debug_message($"[Korutiini][Builder][FAILURE]\n{_message}\n\n");
  CANCEL;
}