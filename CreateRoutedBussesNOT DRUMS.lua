function createTrack(name)
  local trackIndex = reaper.CountTracks(0) -- Get the index for the new track
  reaper.InsertTrackAtIndex(trackIndex, true)
  local track = reaper.GetTrack(0, trackIndex) -- Retrieve the newly created track

  if track then
    reaper.GetSetMediaTrackInfo_String(track, 'P_NAME', name, true)
    return track
  else
    error("Failed to create track: " .. name)
  end
end


function routeTrackTo(source_track, destination_track)
    reaper.SetMediaTrackInfo_Value(source_track, "B_MAINSEND", 0)
    local send_id = reaper.CreateTrackSend(source_track, destination_track)
   
end

function main()
  local busses = {
    BASSs = createTrack('BASSs'),
    TOPs = createTrack('TOPs'),
    GITs = createTrack('GITs'),
    VOXs = createTrack('VOXs'),
    SYNTHs = createTrack('SYNTHs'),
    FXs = createTrack('FXs'),
  }

  routeTrackTo(busses['GITs'], busses['TOPs'])
  routeTrackTo(busses['VOXs'], busses['TOPs'])
  routeTrackTo(busses['SYNTHs'], busses['TOPs'])
  routeTrackTo(busses['FXs'], busses['TOPs'])
  

  reaper.TrackList_AdjustWindows(false)
  reaper.UpdateArrange()
end

main()

