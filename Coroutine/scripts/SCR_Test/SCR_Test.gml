

function TESTER()
{
  return ko_rutiini(_x, _y)
  {
    // This is example.
    ko_delay(0.5, "seconds");
    self.x = _x;
    
    ko_delay(0.5, "seconds");
    self.y = _x;
    
    
    ko_delay(3, "frames");
    
    for(var i = 0; i < 100; i++)
    {
      if (random(100) > i)
      {
        show_debug_message("break");
        break;
      }
    }
    
    ko_delay(5);
  }
}