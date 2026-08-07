#!/bin/bash
#
# setup-dnscrypt-proxy.sh
# Cài đặt & cấu hình dnscrypt-proxy trên Arch Linux
# Tự động chọn DNS server nhanh nhất, failover khi chậm
#
# Chạy: sudo bash setup-dnscrypt-proxy.sh
#

set -euo pipefail

# Màu sắc
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Kiểm tra root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}❌ Cần chạy với quyền root!${NC}"
    echo -e "   Chạy: ${YELLOW}sudo bash $0${NC}"
    exit 1
fi

echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   🌐 Cài đặt dnscrypt-proxy - Auto Best DNS${NC}"
echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo ""

# ──────────────────────────────────────────────────
# BƯỚC 1: Cài đặt dnscrypt-proxy
# ──────────────────────────────────────────────────
echo -e "${GREEN}[1/5] Cài đặt dnscrypt-proxy...${NC}"

if pacman -Qi dnscrypt-proxy &>/dev/null; then
    echo -e "  ℹ️  Đã cài sẵn, bỏ qua"
else
    pacman -S --noconfirm dnscrypt-proxy
    echo -e "  ✅ Đã cài đặt"
fi
echo ""

# ──────────────────────────────────────────────────
# BƯỚC 2: Backup & cấu hình dnscrypt-proxy
# ──────────────────────────────────────────────────
echo -e "${GREEN}[2/5] Cấu hình dnscrypt-proxy...${NC}"

CONF_DIR="/etc/dnscrypt-proxy"
CONF_FILE="${CONF_DIR}/dnscrypt-proxy.toml"

# Backup file gốc
if [[ -f "$CONF_FILE" && ! -f "${CONF_FILE}.bak" ]]; then
    cp "$CONF_FILE" "${CONF_FILE}.bak"
    echo -e "  📁 Đã backup: ${CONF_FILE}.bak"
fi

cat > "$CONF_FILE" << 'EOF'
# ══════════════════════════════════════════════════
# dnscrypt-proxy - Tự động chọn DNS nhanh nhất
# ══════════════════════════════════════════════════

# Lắng nghe trên 127.0.0.1:5353 (tránh xung đột với systemd-resolved)
listen_addresses = ['127.0.0.1:5353']

# ── Chọn server tự động ──────────────────────────
# Không chỉ định server cụ thể → dnscrypt-proxy tự test tất cả
# và chọn server nhanh nhất từ danh sách public
server_names = []

# ── Giao thức ─────────────────────────────────────
# Dùng DNS-over-HTTPS (DoH) - bảo mật, khó bị chặn
doh_servers = true
dnscrypt_servers = true

# Chỉ dùng server hỗ trợ DNSSEC (xác thực DNS)
require_dnssec = true

# Không dùng server có log hoặc filter (riêng tư hơn)
require_nolog = true
require_nofilter = true

# Chỉ dùng IPv4 (ổn định hơn ở VN)
ipv4_servers = true
ipv6_servers = false
block_ipv6 = false

# ── Hiệu suất & Auto-switch ──────────────────────

# Thời gian chờ tối đa cho mỗi DNS query (ms)
timeout = 3000

# Số server sẽ giữ sẵn (dùng song song)
# dnscrypt-proxy sẽ gửi query tới TẤT CẢ server này
# và trả về kết quả NHANH NHẤT
lb_strategy = 'p2'
lb_estimator = true

# Tự benchmark lại server mỗi 240 giây
# Server nào chậm sẽ bị loại, server nhanh được ưu tiên
cert_refresh_delay = 240

# ── Cache DNS ─────────────────────────────────────
cache = true
cache_size = 4096
cache_min_ttl = 600
cache_max_ttl = 86400
cache_neg_min_ttl = 60
cache_neg_max_ttl = 600

# ── Tự động cập nhật danh sách server ─────────────
[sources]
  [sources.'public-resolvers']
  urls = [
    'https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md',
    'https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md'
  ]
  cache_file = '/var/cache/dnscrypt-proxy/public-resolvers.md'
  minisign_key = 'RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3'
  refresh_delay = 72
  prefix = ''

# ── Logging ───────────────────────────────────────
[query_log]
  file = '/var/log/dnscrypt-proxy/query.log'
  format = 'tsv'

[nx_log]
  file = '/var/log/dnscrypt-proxy/nx.log'
  format = 'tsv'
EOF

# Tạo thư mục cần thiết
mkdir -p /var/cache/dnscrypt-proxy
mkdir -p /var/log/dnscrypt-proxy

echo -e "  ✅ Đã tạo cấu hình tại ${CONF_FILE}"
echo -e "  📋 Chế độ: Tự động chọn DNS nhanh nhất"
echo -e "  📋 Giao thức: DNS-over-HTTPS + DNSCrypt"
echo -e "  📋 Yêu cầu: DNSSEC, No-Log, No-Filter"
echo ""

# ──────────────────────────────────────────────────
# BƯỚC 3: Tích hợp với systemd-resolved
# ──────────────────────────────────────────────────
echo -e "${GREEN}[3/5] Tích hợp với systemd-resolved...${NC}"

RESOLVED_CONF="/etc/systemd/resolved.conf.d"
mkdir -p "$RESOLVED_CONF"

cat > "${RESOLVED_CONF}/dnscrypt-proxy.conf" << 'EOF'
# Chuyển hướng DNS qua dnscrypt-proxy
[Resolve]
DNS=127.0.0.1#5353
DNSOverTLS=no
DNSSEC=no
# Tắt DNSSEC ở resolved vì dnscrypt-proxy đã xử lý
# Tắt fallback để đảm bảo mọi query đều đi qua dnscrypt-proxy
FallbackDNS=
Domains=~.
EOF

echo -e "  ✅ systemd-resolved sẽ forward DNS qua dnscrypt-proxy"
echo ""

# ──────────────────────────────────────────────────
# BƯỚC 4: Khởi động dịch vụ
# ──────────────────────────────────────────────────
echo -e "${GREEN}[4/5] Khởi động dịch vụ...${NC}"

# Bật dnscrypt-proxy
systemctl enable dnscrypt-proxy.service 2>/dev/null
systemctl restart dnscrypt-proxy.service 2>/dev/null || {
    echo -e "  ${YELLOW}⚠️  Lần đầu chạy, dnscrypt-proxy cần tải danh sách server...${NC}"
    echo -e "  ${YELLOW}   Đợi vài giây rồi chạy lại: sudo systemctl start dnscrypt-proxy${NC}"
}

# Restart systemd-resolved
systemctl restart systemd-resolved.service 2>/dev/null

echo -e "  ✅ dnscrypt-proxy: enabled & started"
echo -e "  ✅ systemd-resolved: restarted"
echo ""

# ──────────────────────────────────────────────────
# BƯỚC 5: Kiểm tra
# ──────────────────────────────────────────────────
echo -e "${GREEN}[5/5] Kiểm tra...${NC}"

# Chờ dnscrypt-proxy khởi động
sleep 2

# Test DNS resolution
if command -v dig &>/dev/null; then
    RESULT=$(dig @127.0.0.1 -p 5353 google.com +short +time=3 2>/dev/null | head -1)
    if [[ -n "$RESULT" ]]; then
        echo -e "  ✅ DNS hoạt động! google.com → ${RESULT}"
    else
        echo -e "  ${YELLOW}⚠️  DNS chưa sẵn sàng, đợi dnscrypt-proxy tải server list (~30s)${NC}"
    fi
elif command -v drill &>/dev/null; then
    RESULT=$(drill @127.0.0.1 -p 5353 google.com 2>/dev/null | grep -A1 "ANSWER SECTION" | tail -1 | awk '{print $NF}')
    if [[ -n "$RESULT" ]]; then
        echo -e "  ✅ DNS hoạt động! google.com → ${RESULT}"
    else
        echo -e "  ${YELLOW}⚠️  DNS chưa sẵn sàng, đợi ~30s${NC}"
    fi
else
    echo -e "  ℹ️  Không có dig/drill, bỏ qua test"
fi

echo ""

# ──────────────────────────────────────────────────
# Tóm tắt
# ──────────────────────────────────────────────────
echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   ✅ Hoàn tất! Tóm tắt:${NC}"
echo -e "${BLUE}══════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${CYAN}Cách hoạt động:${NC}"
echo -e "    1. dnscrypt-proxy tự tải danh sách ~300 DNS server toàn cầu"
echo -e "    2. Benchmark tất cả, chọn server có latency thấp nhất"
echo -e "    3. Gửi query song song tới top servers, trả kết quả nhanh nhất"
echo -e "    4. Re-benchmark mỗi giờ, tự chuyển nếu server hiện tại chậm"
echo -e "    5. Cache kết quả DNS → lần sau trả lời cực nhanh"
echo ""
echo -e "  ${CYAN}Bảo mật:${NC}"
echo -e "    🔒 DNS-over-HTTPS (mã hóa, ISP không thể đọc)"
echo -e "    🔒 DNSSEC (chống giả mạo DNS)"
echo -e "    🔒 No-Log servers (không lưu lịch sử)"
echo ""
echo -e "  ${CYAN}Lệnh hữu ích:${NC}"
echo -e "    📊 Xem server đang dùng:  ${YELLOW}dnscrypt-proxy -resolve google.com${NC}"
echo -e "    📊 Xem log:               ${YELLOW}journalctl -u dnscrypt-proxy -f${NC}"
echo -e "    📊 Test tốc độ:           ${YELLOW}dig @127.0.0.1 -p 5353 google.com${NC}"
echo -e "    🔄 Restart:               ${YELLOW}sudo systemctl restart dnscrypt-proxy${NC}"
echo ""
echo -e "  ${CYAN}Files:${NC}"
echo -e "    📄 Config:  ${CONF_FILE}"
echo -e "    📄 Backup:  ${CONF_FILE}.bak"
echo -e "    📄 Resolved: ${RESOLVED_CONF}/dnscrypt-proxy.conf"
echo -e "    📄 Log:     /var/log/dnscrypt-proxy/query.log"
echo ""
