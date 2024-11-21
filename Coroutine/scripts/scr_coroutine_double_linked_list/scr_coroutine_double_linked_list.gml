

/// @func CoroutineDoubleLinkedList();
/// @desc Double-linked lists, so it is easier to remove and add items without messing with indexes.
function CoroutineDoubleLinkedList() constructor
{
  self.head = undefined;
  self.tail = undefined;
  
  
  /// @func Node(_data);
  /// @desc Creates node, which holds linked-list data.
  /// @param {Any} _data
  /// @returns {Struct.CoroutineDoubleLinkedListNode}
  static Node = function(_data)
  {
    return new CoroutineDoubleLinkedListNode(_data);
  };
  
  
  /// @func InsertHead(_node);
  /// @desc Inserts at the beginning.
  /// @param {Struct.CoroutineDoubleLinkedListNode} _node
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static InsertHead = function(_node)
  {
    if (_node.list != undefined)
    {
      _node.Detach();
    }
    _node.next = head;
    _node.prev = undefined;
    _node.list = self;
    if (head != undefined)
    {
      head.prev = _node;
    }
    else
    {
      tail = _node;
    }
    head = _node;
    return self;
  };
  
  
  /// @func InsertTail(_node);
  /// @desc Inserts at the end.
  /// @param {Struct.CoroutineDoubleLinkedListNode} _node
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static InsertTail = function(_node)
  {
    if (_node.list != undefined)
    {
      _node.Detach();
    }
    _node.next = undefined;
    _node.prev = tail;
    _node.list = self;
    if (tail != undefined)
    {
      tail.next = _node;
    }
    else
    {
      head = _node;
    }
    tail = _node;
    return self;
  };
  
  
  /// @func DeleteHead();
  /// @desc Deletes head.
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static DeleteHead = function()
  {
    if (head == undefined) return self;
    head.Detach();
    return self;
  };
  
  
  /// @func DeleteTail();
  /// @desc Deletes tail.
  /// @returns {Struct.CoroutineDoubleLinkedList}
  static DeleteTail = function()
  {
    if (tail == undefined) return self;
    tail.Detach();
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
      _node.list = undefined;
      _node = _next;
    }
    self.head = undefined;
    self.tail = undefined;
    return self;
  };
}



/// @func CoroutineDoubleLinkedListNode(_data);
/// @desc 
/// @param {Any} _data
function CoroutineDoubleLinkedListNode(_data) constructor
{
  self.next = undefined;
  self.prev = undefined;
  self.list = undefined;
  self.item = _data;
  
  
  /// @func Detach();
  /// @desc Removes node from linked list it is currently.
  static Detach = function()
  {
    // Handle the prev -link.
    if (prev != undefined)
    {
      prev.next = next;
    }
    else if (list.head == self)
    {
      list.head = next;
    }
    
    // Handle the next -link.
    if (next != undefined)
    {
      next.prev = prev;
    }
    else if (list.tail == self)
    {
      list.tail = prev;
    }
    
    // Clear the node.
    next = undefined;
    prev = undefined;
    list = undefined;
  };
}











