

/// @func coroutine_mapping(_array);
/// @desc
/// @param {Array<Any>} _array
/// @returns {Struct}
function coroutine_mapping(_array)
{
  var _mapping = {};
  var _countOuter = array_length(_array);
  for(var i = 0; i < _countOuter; i+=2)
  {
    var _lhs = _array[i + 0];
    var _rhs = _array[i + 1];
    _rhs = method(undefined, _rhs);
    
    var _countInner = array_length(_lhs);
    for(var j = 0; j < _countInner; j++)
    {
      _mapping[$ _lhs[j]] = _rhs;
    }
  }
  return _mapping;
}


/// @func coroutine_frame_time_get();
/// @desc Tells how much time has passed since frame started.
/// @returns {Real}
function coroutine_frame_time_get()
{
  return (get_timer() - COROUTINE_FRAME_TIME_BEGIN);
}


/// @func coroutine_frame_time_usage();
/// @desc Returns how much of frame time budget has been used already.
/// @returns {Real}
function coroutine_frame_time_usage()
{
  return coroutine_frame_time_get() / game_get_speed(gamespeed_microseconds);
}


/// @func CoroutineDoubleLinkedList();
/// @desc 
function CoroutineDoubleLinkedList() constructor
{
  self.head = undefined;
  self.tail = undefined;
  
  
  /// @func InsertHead(_coroutine);
  /// @desc Inserts at the beginning.
  /// @param {Struct.Coroutine} _coroutine
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static InsertHead = function(_coroutine)
  {
    _coroutine.next = head;
    _coroutine.prev = undefined;
    if (head != undefined)
    {
      head.prev = _coroutine;
    }
    else
    {
      tail = _coroutine;
    }
    head = _coroutine;
    return self;
  };
  
  
  /// @func InsertTail(_coroutine);
  /// @desc Inserts at the end.
  /// @param {Struct.Coroutine} _coroutine
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static InsertTail = function(_coroutine)
  {
    _coroutine.next = undefined;
    _coroutine.prev = tail;
    if (tail != undefined)
    {
      tail.next = _coroutine;
    }
    else
    {
      head = _coroutine;
    }
    tail = _coroutine;
    return self;
  };
  
  
  /// @func DeleteHead();
  /// @desc Deletes head.
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static DeleteHead = function()
  {
    if (head == undefined) return self;
    
    if (head.next != undefined)
    {
      head.next.prev = undefined;
    }
    else
    {
      tail = undefined;
    }
    head = head.next;
    return self;
  };
  
  
  /// @func DeleteTail();
  /// @desc Deletes tail.
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static DeleteTail = function()
  {
    if (tail == undefined) return self;
    
    if (tail.prev != undefined)
    {
      tail.prev.next = undefined;
    }
    else
    {
      head = undefined;
    }
    tail = tail.prev;
    return self;
  };
  
  
  /// @func Detach(_coroutine);
  /// @desc Removes coroutine from linked list it is currently (not this specifc one).
  /// @param {Struct.Coroutine} _coroutine
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static Detach = function(_coroutine)
  {
    // Handle the prev -link.
    if (_coroutine.prev != undefined)
    {
      _coroutine.prev.next = _coroutine.next;
    }
    else if (head == _coroutine)
    {
      head = _coroutine.next;
    }
    
    // Handle the next -link.
    if (_coroutine.next != undefined)
    {
      _coroutine.next.prev = _coroutine.prev;
    }
    else if (tail == _coroutine)
    {
      tail = _coroutine.prev;
    }
    
    // Clear the node.
    _coroutine.prev = undefined;
    _coroutine.next = undefined;
    return self;
  };
  
  
  /// @func Size();
  /// @desc Iterates over the items to find the size of the list, O(N) operation.
  /// @returns {Real}
  static Size = function()
  {
    var _size = 0;
    var _node = self.head;
    while(_node != undefined)
    {
      _node = _node.next;
      _size++;
    }
    return _size;
  };
  
  
  /// @func Free();
  /// @desc 
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static Free = function()
  {
    var _node = self.head;
    while(_node != undefined)
    {
      var _next = _node.next;
      _node.prev = undefined;
      _node.next = undefined;
      _node = _next;
    }
    self.head = undefined;
    self.tail = undefined;
    return self;
  };
}












