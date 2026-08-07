#!/bin/bash
# Launch Genshin Impact qua TwintailLauncher với GPU tối ưu
# Đảm bảo NVIDIA GPU active trước khi launch

echo "🎮 Chuẩn bị khởi động Genshin Impact..."

# Wake up NVIDIA GPU nếu đang suspended
if [ -f /sys/bus/pci/devices/0000:01:00.0/power/control ]; then
    echo "on" | sudo tee /sys/bus/pci/devices/0000:01:00.0/power/control > /dev/null 2>&1
    sleep 1
fi

# Kiểm tra GPU status
GPU_STATUS=$(cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status 2>/dev/null)
echo "   GPU power status: $GPU_STATUS"

# Launch với env vars đầy đủ
exec env \
    WINEFSYNC=1 \
    WINEESYNC=1 \
    DXVK_ASYNC=1 \
    MESA_VK_DEVICE_SELECT="10de:1f91" \
    DXVK_FILTER_DEVICE_NAME="NVIDIA" \
    __NV_PRIME_RENDER_OFFLOAD=1 \
    __VK_LAYER_NV_optimus=NVIDIA_only \
    __GLX_VENDOR_LIBRARY_NAME=nvidia \
    gamemoderun \
    twintaillauncher
