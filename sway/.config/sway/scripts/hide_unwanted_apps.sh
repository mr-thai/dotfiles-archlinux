#!/bin/bash

echo "Đang dọn dẹp các ứng dụng rác khỏi App Launcher..."

mkdir -p ~/.local/share/applications

# Danh sách các pattern (mẫu) file cần ẩn
PATTERNS=(
    "/usr/share/applications/*java*.desktop"
    "/usr/share/applications/electron*.desktop"
    "/usr/share/applications/avahi-*.desktop"
    "/usr/share/applications/bssh.desktop"
    "/usr/share/applications/bvnc.desktop"
    "/usr/share/applications/qemu.desktop"
    "/usr/share/applications/qv4l2.desktop"
    "/usr/share/applications/qvidcap.desktop"
    "/usr/share/applications/xgps*.desktop"
)

# Bật tính năng nullglob để nếu không tìm thấy file, vòng lặp sẽ bỏ qua thay vì lỗi
shopt -s nullglob

for pattern in "${PATTERNS[@]}"; do
    for app in $pattern; do
        if [ -f "$app" ]; then
            name=$(basename "$app")
            echo "Đang ẩn: $name"
            cp "$app" ~/.local/share/applications/
            
            # Chỉ thêm NoDisplay nếu chưa có
            if ! grep -q "NoDisplay=true" ~/.local/share/applications/"$name"; then
                echo "NoDisplay=true" >> ~/.local/share/applications/"$name"
            fi
        fi
    done
done

echo "Hoàn tất! Vui lòng khởi động lại menu ứng dụng (Fuzzel/Wofi) để thấy sự thay đổi."
