

/**
* Fails and stops the builder.
*/ 
function KorutiiniBuilder_Failure(_message)
{
  show_debug_message($"[Korutiini][Builder][Error]\n{_message}\n\n");
  CANCEL;
}