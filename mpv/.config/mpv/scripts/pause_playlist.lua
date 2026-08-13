-- Tự động Pause CHỈ KHI video tự động next sang bài tiếp theo (hết thời gian).
-- Sẽ KHÔNG pause nếu người dùng chủ động bấm chọn video trong danh sách.

local advanced_by_eof = false

mp.register_event("end-file", function(event)
    -- Nếu video kết thúc một cách tự nhiên (eof - End of File)
    if event.reason == "eof" then
        advanced_by_eof = true
    else
        -- Nếu người dùng bấm next, hoặc chủ động chọn bài khác thì reason sẽ là "stop" hoặc "quit"
        advanced_by_eof = false
    end
end)

mp.register_event("file-loaded", function()
    if advanced_by_eof then
        mp.set_property_bool("pause", true)
    end
    -- Reset lại trạng thái
    advanced_by_eof = false
end)
