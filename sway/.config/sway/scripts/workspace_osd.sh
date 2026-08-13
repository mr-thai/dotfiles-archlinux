#!/bin/bash
echo "Workspace OSD script started at $(date)" >> /tmp/workspace_osd_debug.log

# Vòng lặp vô hạn để tự động kết nối lại nếu Sway IPC chưa sẵn sàng (khi mới boot)
while true; do
    # Lắng nghe sự kiện chuyển Workspace từ Sway IPC
    swaymsg -t subscribe -m '["workspace"]' | while read -r line; do
        # Lấy tên của Workspace vừa được Focus
        WS=$(echo "$line" | jq -r 'select(.change == "focus") | .current.name' 2>/dev/null)
        
        if [ -n "$WS" ] && [ "$WS" != "null" ]; then
            echo "Changing to workspace $WS at $(date)" >> /tmp/workspace_osd_debug.log
            # Cập nhật số Workspace vào EWW
            eww update current_workspace="$WS"
            
            # Mở popup OSD giữa màn hình
            eww open workspace_osd
            
            # Hủy tất cả các lệnh đóng đang chờ từ trước
            pkill -f "sleep 0.3; eww close workspace_osd"
            
            # Đặt lịch đóng popup sau 0.3 giây
            bash -c "sleep 0.3; eww close workspace_osd" &
        fi
    done
    
    # Đợi 1 giây rồi thử lại nếu lệnh swaymsg bị lỗi (do Sway chưa khởi động xong)
    sleep 1
done
