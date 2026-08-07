#!/bin/bash
# === Genshin Impact Performance Boost ===
# Run this command before entering the game to optimize performance

echo "🚀 Boosting performance for Genshin Impact..."

# 1. Push Intel GPU to max freq (Most important!)
GPU_MAX=$(cat /sys/class/drm/card1/gt_max_freq_mhz 2>/dev/null || echo 1050)
echo "$GPU_MAX" | sudo tee /sys/class/drm/card1/gt_min_freq_mhz > /dev/null
echo "✅ GPU: $(cat /sys/class/drm/card1/gt_min_freq_mhz)MHz / ${GPU_MAX}MHz"

# 2. CPU performance governor (already enabled, keep as is)
echo "✅ CPU governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"

# 3. Disable CPU frequency scaling while gaming
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq; do
    MAX=$(cat "${cpu/min/max}" 2>/dev/null)
    [ -n "$MAX" ] && echo "$MAX" | sudo tee "$cpu" > /dev/null
done
echo "✅ CPU: Set min freq = max freq"

# 4. Disable kernel writeback to reduce I/O jitter
echo "5" | sudo tee /proc/sys/vm/dirty_writeback_centisecs > /dev/null
echo 1 | sudo tee /proc/sys/vm/swappiness > /dev/null 2>&1
echo "✅ I/O: Reduced swappiness & writeback delay"

echo ""
echo "🎮 Ready! Jump into the game now."
echo "   (These changes will automatically reset after reboot)"
