/// @desc RECORDING.

skipped = false;


// Check whether recording is possible.
if (audio_get_recorder_count() <= 0)
{
  show_message_async("No recorders available.");
  skipped = true;
  exit;
}


// Create the buffer to store recording.
dtype = buffer_f64;
dsize = buffer_sizeof(dtype);
bytes = 160_000; // Guess 5 seconds.
buffer = buffer_create(bytes, buffer_fixed, 1);
sound = undefined;


// Coroutine action for recording and then playing the clip.
COROUTINE 
  name: "Recording",
  desc: "This coroutine will record about 5 second clip.",
  
ON_CLEANUP
  array_foreach(recorderArray, function(_recorder, i) 
  {
    ds_map_destroy(_recorder);
  });

BEGIN
  
  // Get information about audio recorders.
  recorderIndex = 0;
  recorderArray = [];
  recorderCount = audio_get_recorder_count();
  for(var i = 0; i < recorderCount; i++)
  {
    array_push(recorderArray, audio_get_recorder_info(i));
  }
  
  
  // Choose recorder from all available.
  requestIndex = ASYNC_REQUEST
      name: "Get recorder",
      desc: "This requests user to select recorder."
      
    DO_REQUEST 
      var _str = "Please select recorder:\n";
      for(var i = 0; i < recorderCount; i++)
      {
        var _recorder = recorderArray[i];
        _str += $" [{_recorder[? "index"]}] {_recorder[? "name"]}\n";
      };
      return get_integer_async(_str, 0);
      
    ON_SUCCESS
      recorderIndex = async_load[? "value"];
      if (is_string(recorderIndex))
      || (recorderIndex < 0)
      || (recorderIndex >= recorderCount)
      {
        _async.Failure();
        return;
      }
      show_debug_message($"Recorder [{recorderIndex}] was selected.");
    
    ON_FAILURE
      show_debug_message($"Selecting recorder has failed.");
      
  ASYNC_END
  
  
  // Check whether acceptable recorder was received. 
  AWAIT_REQUESTS
  if (requestIndex.hasFailed())
  {
    show_debug_message("Aborting the recording.");
    EXIT;
  }
    
  
  // Start recording.
  offset = 0;
  channel = audio_start_recording(recorderIndex);
  requestRecord = ASYNC_LISTENER
      type: ev_async_audio_recording,
      name: "Record listener",
      desc: "This async event triggers when recorder has data to give",
      
    ON_LISTEN
      if (channel != async_load[? "channel_index"])
        return;
        
      // Copy recording to buffer.
      var _len = min(async_load[? "data_len"], this.bytes - offset);
      buffer_copy(async_load[? "buffer_id"], 0, _len, this.buffer, offset);
      offset += _len;
      
      // Finish listening.
      if (offset >= this.bytes)
      {
        show_debug_message("Recording finished!");
        audio_stop_recording(channel);
        _async.Destroy();
      }
  ASYNC_END
  
  
  // Wait while recording is done.
  COROUTINE BEGIN
    time = current_time;
    WHILE (this.requestRecord.isFinished() == false) THEN 
      show_debug_message($"Recording... {(current_time - time) / 1_000.0} s");
      DELAY 0.5 SECONDS
    END
  FINISH DISPATCH
  
  AWAIT_LISTENERS
  AWAIT_SUBTASKS
  
  
  // Create audio from buffer.
  recorder = recorderArray[recorderIndex];
  this.sound = audio_create_buffer_sound(
    this.buffer,
    recorder[? "data_format"],
    recorder[? "sample_rate"],
    0, this.bytes,
    recorder[? "channels"]
  );
  
  
  // Now finally play sound!
  show_debug_message($"Sound starts playing now!");
  ASYNC_REQUEST
    DO_REQUEST return audio_play_sound(this.sound, 0, false);
    ON_SUCCESS show_debug_message($"[{_async.request}] Success!");
  ASYNC_END
  AWAIT_REQUESTS
  show_debug_message($"Sound has played!");
  
  
FINISH DISPATCH






