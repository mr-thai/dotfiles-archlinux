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
    
    local current_time = mp.get_property_number("time-pos")
    
    if not start_time then
        start_time = current_time
        mp.osd_message("✂️ Đã đánh dấu điểm ĐẦU (Start)\nBấm 'x' lần nữa để chọn điểm Cuối", 2)
    else
        local end_time = current_time
        
        if end_time <= start_time then
            mp.osd_message("❌ Điểm cuối phải lớn hơn điểm đầu! Đã hủy.", 2)
            start_time = nil
            return
        end

        local out_path = get_out_filename(in_path)
        mp.osd_message("⏳ Đang cắt video (Không làm giảm chất lượng)...", 3)
        
        -- Dùng FFmpeg để cắt không cần render lại (lossless, siêu tốc)
        local args = {
            "ffmpeg",
            "-y",
            "-i", in_path,
            "-ss", tostring(start_time),
            "-to", tostring(end_time),
            "-c", "copy",
            out_path
        }

        mp.command_native_async({
            name = "subprocess",
            playback_only = false,
            args = args,
        }, function(success, result, error)
            if success and result.status == 0 then
                mp.osd_message("✅ Đã cắt xong!\nLưu tại: " .. out_path, 4)
            else
                mp.osd_message("❌ Lỗi khi cắt video! Cần cài đặt FFmpeg.", 4)
                msg.error("FFmpeg error: " .. tostring(error))
            end
        end)
        
        -- Reset trạng thái
        start_time = nil
    end
end

local function cancel_cut()
    if start_time then
        start_time = nil
        mp.osd_message("🚫 Đã hủy thao tác cắt video", 2)
    end
end

mp.add_key_binding("x", "cut_video", do_cut)
mp.add_key_binding("X", "cancel_cut_video", cancel_cut)
