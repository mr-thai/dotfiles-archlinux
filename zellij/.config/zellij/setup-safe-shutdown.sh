#!/bin/bash
#
# setup-safe-shutdown.sh
# Cấu hình chống treo khi shutdown/reboot trên Linux
# Chạy: sudo bash setup-safe-shutdown.sh
#

set -euo pipefail

# Màu sắc cho output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Kiểm tra quyền root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}❌ Script này cần chạy với quyền root!${NC}"
    echo -e "   Chạy lại: ${YELLOW}sudo bash $0${NC}"
    exit 1
fi

echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   🛡️  Cấu hình chống treo Shutdown/Reboot${NC}"
echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo ""

# ──────────────────────────────────────────────────
# LỚP 1: Giảm Systemd Shutdown Timeout
# ──────────────────────────────────────────────────
echo -e "${GREEN}[1/3] Cấu hình Systemd Timeout...${NC}"

SYSTEMD_CONF="/etc/systemd/system.conf"

# Backup file gốc nếu chưa có backup
if [[ ! -f "${SYSTEMD_CONF}.bak" ]]; then
    cp "$SYSTEMD_CONF" "${SYSTEMD_CONF}.bak"
    echo -e "  📁 Đã backup: ${SYSTEMD_CONF}.bak"
fi

# Hàm để set hoặc update một config trong systemd
set_systemd_conf() {
    local key="$1"
    local value="$2"
    local file="$3"

    if grep -q "^${key}=" "$file" 2>/dev/null; then
        # Đã có và đang bật → update giá trị
        sed -i "s|^${key}=.*|${key}=${value}|" "$file"
    elif grep -q "^#${key}=" "$file" 2>/dev/null; then
        # Đang bị comment → bỏ comment và set giá trị
        sed -i "s|^#${key}=.*|${key}=${value}|" "$file"
    else
        # Chưa có → thêm vào cuối section [Manager]
        sed -i "/^\[Manager\]/a ${key}=${value}" "$file"
    fi
}

set_systemd_conf "DefaultTimeoutStopSec" "15s" "$SYSTEMD_CONF"
set_systemd_conf "DefaultTimeoutAbortSec" "10s" "$SYSTEMD_CONF"

echo -e "  ✅ DefaultTimeoutStopSec=15s  (mặc định: 90s)"
echo -e "  ✅ DefaultTimeoutAbortSec=10s (mặc định: 90s)"
echo ""

# ──────────────────────────────────────────────────
# LỚP 2: Systemd Watchdog
# ──────────────────────────────────────────────────
echo -e "${GREEN}[2/3] Cấu hình Systemd Watchdog...${NC}"

set_systemd_conf "RuntimeWatchdogSec" "30s" "$SYSTEMD_CONF"
set_systemd_conf "RebootWatchdogSec" "5min" "$SYSTEMD_CONF"
set_systemd_conf "ShutdownWatchdogSec" "5min" "$SYSTEMD_CONF"
set_systemd_conf "KExecWatchdogSec" "5min" "$SYSTEMD_CONF"

echo -e "  ✅ RuntimeWatchdogSec=30s   (kernel treo > 30s → tự reboot)"
echo -e "  ✅ RebootWatchdogSec=5min   (reboot treo > 5 phút → force)"
echo -e "  ✅ ShutdownWatchdogSec=5min (shutdown treo > 5 phút → force)"
echo -e "  ✅ KExecWatchdogSec=5min    (kexec treo > 5 phút → force)"
echo ""

# ──────────────────────────────────────────────────
# LỚP 3: Bật SysRq + Kernel Panic auto reboot
# ──────────────────────────────────────────────────
echo -e "${GREEN}[3/3] Cấu hình SysRq & Kernel Panic...${NC}"

SYSCTL_CONF="/etc/sysctl.d/99-safe-shutdown.conf"

cat > "$SYSCTL_CONF" << 'EOF'
# ──────────────────────────────────────────────────
# Cấu hình chống treo khi shutdown/reboot
# Tạo bởi setup-safe-shutdown.sh
# ──────────────────────────────────────────────────

# Bật tất cả SysRq functions (Alt+PrtSc+...)
# Cho phép dùng phím tắt để force sync/reboot khi hệ thống treo
kernel.sysrq = 1

# Tự động reboot sau 10 giây khi kernel panic
kernel.panic = 10

# Trigger panic khi hết RAM (thay vì treo vô hạn)
vm.panic_on_oom = 1
EOF

# Áp dụng ngay
sysctl --system > /dev/null 2>&1

echo -e "  ✅ kernel.sysrq=1        (bật phím cứu SysRq)"
echo -e "  ✅ kernel.panic=10       (kernel panic → reboot sau 10s)"
echo -e "  ✅ vm.panic_on_oom=1     (hết RAM → panic → reboot)"
echo ""

# ──────────────────────────────────────────────────
# Áp dụng systemd config
# ──────────────────────────────────────────────────
echo -e "${GREEN}Áp dụng cấu hình systemd...${NC}"
systemctl daemon-reexec 2>/dev/null || systemctl daemon-reload 2>/dev/null || true
echo -e "  ✅ Đã reload systemd"
echo ""

# ──────────────────────────────────────────────────
# Tóm tắt
# ──────────────────────────────────────────────────
echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   ✅ Hoàn tất! Tóm tắt cấu hình:${NC}"
echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${YELLOW}Lớp 1 - Systemd Timeout:${NC}"
echo -e "    Service không tắt trong 15s → bị kill"
echo ""
echo -e "  ${YELLOW}Lớp 2 - Watchdog:${NC}"
echo -e "    Kernel treo > 30s → tự reboot"
echo -e "    Shutdown/Reboot treo > 5 phút → force reboot"
echo ""
echo -e "  ${YELLOW}Lớp 3 - SysRq & Panic:${NC}"
echo -e "    Kernel panic → tự reboot sau 10s"
echo -e "    Hết RAM → tự reboot"
echo -e "    Phím cứu: Alt+PrtSc+R,E,I,S,U,B"
echo ""
echo -e "  ${YELLOW}Files đã tạo/sửa:${NC}"
echo -e "    📄 ${SYSTEMD_CONF} (backup: ${SYSTEMD_CONF}.bak)"
echo -e "    📄 ${SYSCTL_CONF}"
echo ""
echo -e "  ${GREEN}Không cần reboot. Cấu hình đã áp dụng ngay!${NC}"
echo ""
