#!/bin/bash
# fix-dnscrypt-direct.sh
# Cho dnscrypt-proxy listen trực tiếp trên 127.0.0.1:53
# Bỏ qua systemd-resolved hoàn toàn
#
# Chạy: sudo bash fix-dnscrypt-direct.sh

set -euo pipefail

echo "🔧 Chuyển dnscrypt-proxy sang listen trực tiếp (port 53)..."
echo ""

# 1. Tắt systemd-resolved (không cần nữa)
echo "[1/4] Tắt systemd-resolved..."
systemctl stop systemd-resolved
systemctl disable systemd-resolved
echo "  ✅ systemd-resolved: disabled"

# 2. Cập nhật dnscrypt-proxy listen trên port 53
echo "[2/4] Cập nhật dnscrypt-proxy → port 53..."
sed -i "s|listen_addresses = \['127.0.0.1:5300'\]|listen_addresses = ['127.0.0.1:53']|" \
    /etc/dnscrypt-proxy/dnscrypt-proxy.toml

# Nếu vẫn còn port 5353 (chưa từng sửa)
sed -i "s|listen_addresses = \['127.0.0.1:5353'\]|listen_addresses = ['127.0.0.1:53']|" \
    /etc/dnscrypt-proxy/dnscrypt-proxy.toml

echo "  ✅ dnscrypt-proxy.toml → 127.0.0.1:53"

# 3. Cập nhật /etc/resolv.conf trỏ trực tiếp tới dnscrypt-proxy
echo "[3/4] Cập nhật /etc/resolv.conf..."

# Xóa symlink cũ (nếu trỏ tới systemd-resolved)
if [[ -L /etc/resolv.conf ]]; then
    rm /etc/resolv.conf
fi

cat > /etc/resolv.conf << 'EOF'
# DNS qua dnscrypt-proxy (tự động chọn server nhanh nhất)
nameserver 127.0.0.1
options edns0
EOF

# Chống bị ghi đè bởi NetworkManager hoặc DHCP
chattr +i /etc/resolv.conf 2>/dev/null || true

echo "  ✅ /etc/resolv.conf → 127.0.0.1 (immutable)"

# 4. Restart dnscrypt-proxy
echo "[4/4] Restart dnscrypt-proxy..."
systemctl restart dnscrypt-proxy

sleep 3

# Kiểm tra
echo ""
echo "══════════════════════════════════════════════════"
echo "  Kiểm tra kết quả:"
echo "══════════════════════════════════════════════════"
echo ""

# Service status
if systemctl is-active dnscrypt-proxy &>/dev/null; then
    echo "✅ dnscrypt-proxy: RUNNING"
else
    echo "❌ dnscrypt-proxy: FAILED"
    journalctl -u dnscrypt-proxy -n 10 --no-pager
    exit 1
fi

# Port check
echo ""
if ss -tlunp | grep -q ':53 '; then
    echo "✅ Đang listen trên port 53"
else
    echo "⚠️  Chưa thấy port 53"
fi

# DNS test
echo ""
RESULT=$(getent hosts google.com 2>/dev/null | head -1)
if [[ -n "$RESULT" ]]; then
    echo "✅ DNS hoạt động: google.com → ${RESULT}"
else
    echo "⚠️  DNS chưa sẵn sàng, đợi vài giây..."
    sleep 5
    RESULT=$(getent hosts google.com 2>/dev/null | head -1)
    if [[ -n "$RESULT" ]]; then
        echo "✅ DNS hoạt động: google.com → ${RESULT}"
    else
        echo "❌ DNS chưa hoạt động. Kiểm tra: journalctl -u dnscrypt-proxy -f"
    fi
fi

echo ""
echo "🎉 Hoàn tất! Mọi DNS query giờ đi qua dnscrypt-proxy"
echo ""
echo "📋 Lưu ý:"
echo "   • Nếu cần sửa /etc/resolv.conf sau này: sudo chattr -i /etc/resolv.conf"
echo "   • Nếu muốn bật lại systemd-resolved: sudo systemctl enable --now systemd-resolved"
