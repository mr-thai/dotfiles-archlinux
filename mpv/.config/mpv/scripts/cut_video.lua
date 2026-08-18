local utils = require("mp.utils")
local msg = require("mp.msg")

local start_time = nil

local function get_out_filename(in_path)
    local dir, filename = utils.split_path(in_path)
    local name = filename:match("(.+)%.[^%.]+$") or filename
    local ext = filename:match("^.+(%.[^%.]+)$") or ".mp4"
    return utils.join_path(dir, name .. "_cut_" .. tostring(math.floor(mp.get_time())) .. ext)
end

local function do_cut()
    local in_path = mp.get_property("path")
    if not in_path then return end

    -- Expand to an absolute local path (strip "file://" scheme if present)
    in_path = in_path:gsub("^file://", "")
    
    local current_time = mp.get_property_number("time-pos")
    if not current_time then
        mp.osd_message("No valid playback position yet", 2)
        return
    end
    
    if not start_time then
        start_time = current_time
        mp.osd_message("Marked Start point\nPress 'x' again to choose End point", 2)
    else
        local end_time = current_time
        
        if end_time <= start_time then
            mp.osd_message("End point must be after Start point! Canceled.", 2)
            start_time = nil
            return
        end

        local out_path = get_out_filename(in_path)
        mp.osd_message("Cutting video (lossless)...", 3)
        
        -- Use FFmpeg stream copy for a fast lossless cut without re-encoding.
        -- -ss BEFORE -i = input seeking (fast, keyframe-accurate for stream copy).
        -- -to AFTER -i limits output duration; -map 0 keeps ALL streams.
        local args = {
            "ffmpeg",
            "-y",
            "-ss", tostring(start_time),
            "-i", in_path,
            "-to", tostring(end_time),
            "-c", "copy",
            "-map", "0",
            out_path
        }

        mp.command_native_async({
            name = "subprocess",
            playback_only = false,
            args = args,
        }, function(success, result, error)
            if success and result.status == 0 then
                mp.osd_message("Cut done!\nSaved to: " .. out_path, 4)
            else
                mp.osd_message("Cut failed! FFmpeg is required.", 4)
                msg.error("FFmpeg error: " .. tostring(error))
            end
        end)
        
        -- Reset state
        start_time = nil
    end
end

local function cancel_cut()
    if start_time then
        start_time = nil
        mp.osd_message("Cut canceled", 2)
    end
end

mp.add_key_binding("x", "cut_video", do_cut)
mp.add_key_binding("X", "cancel_cut_video", cancel_cut)
