/// @desc SINGLETON.
KORUTIINI_SINGLETON

// Set as last instance to draw.
depth = -15_999; // Note that execution order based on depth is actually undefined behaviour!

self.margin = 0.9;


// Fetch the async-handles.
self.asyncRequests  = __KorutiiniRuntime_AsyncRequests();
self.asyncListeners = __KorutiiniRuntime_AsyncListeners();
