-- Tự động đổi Preset EasyEffects khi xem phim
mp.register_event("file-loaded", function()
    -- Khi MPV bắt đầu chạy video, gọi EasyEffects nạp cấu hình Phim
    os.execute('easyeffects -l "Movies_Cinematic" > /dev/null 2>&1 &')
end)

mp.register_event("shutdown", function()
    -- Khi tắt MPV, gọi EasyEffects trả lại cấu hình Mặc định (All_In_One_Master)
    os.execute('easyeffects -l "All_In_One_Master" > /dev/null 2>&1 &')
end)
