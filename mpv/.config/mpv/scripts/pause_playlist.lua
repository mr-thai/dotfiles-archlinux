-- Pause ONLY when the video auto-advances to the next entry (natural end of file).
-- Will NOT pause if the user manually picks an entry from the playlist.

local advanced_by_eof = false

mp.register_event("end-file", function(event)
    -- If the video ends naturally (eof - End of File)
    if event.reason == "eof" then
        advanced_by_eof = true
    else
        -- If the user pressed next, or manually selected another entry, reason will be "stop" or "quit"
        advanced_by_eof = false
    end
end)

mp.register_event("file-loaded", function()
    if advanced_by_eof then
        mp.set_property_bool("pause", true)
    end
    -- Reset state
    advanced_by_eof = false
end)
