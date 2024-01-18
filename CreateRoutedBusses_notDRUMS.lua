-- 1. creates tracks for vocals, guitars, synths and fx busses and routes them into into a "notDRUMs" bus, instead of the masterbus 
function createTrack(name)
  local trackIndex = reaper.CountTracks(0) -- Get the index for the new track
  reaper.InsertTrackAtIndex(trackIndex, true)-- Create new track at index
  local track = reaper.GetTrack(0, trackIndex) -- Retrieve the newly created track

  if track then
    reaper.GetSetMediaTrackInfo_String(track, 'P_NAME', name, true) -- renames track like functions variable
    return track
  else
    error("Failed to create track: " .. name)
  end
end


function routeTrackTo(source_track, destination_track)
    reaper.SetMediaTrackInfo_Value(source_track, "B_MAINSEND", 0)-- mutes the send to master
    local send_id = reaper.CreateTrackSend(source_track, destination_track)-- creates new send 
   
end

function main()
  local busses = {-- creates a key-value-grid in which  the new created tracks will live for later referencing
    BASSs = createTrack('BASSs'),
    TOPs = createTrack('notDRUMs'),
    GITs = createTrack('GITs'),
    VOXs = createTrack('VOXs'),
    SYNTHs = createTrack('SYNTHs'),
    FXs = createTrack('FXs'),
  }

  routeTrackTo(busses['GITs'], busses['notDRUMs'])-- routing tracks into drum bus using the key-value-grid "busses"
  routeTrackTo(busses['VOXs'], busses['notDRUMs'])
  routeTrackTo(busses['SYNTHs'], busses['notDRUMs'])
  routeTrackTo(busses['FXs'], busses['notDRUMs'])
  

  reaper.TrackList_AdjustWindows(false)-- refreshing GUI
  reaper.UpdateArrange()
end

main()

