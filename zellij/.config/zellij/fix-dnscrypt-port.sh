#!/bin/bash
# fix-dnscrypt-port.sh
# Sửa lỗi port 5353 bị chiếm → chuyển sang port 5300
# Chạy: sudo bash fix-dnscrypt-port.sh

set -euo pipefail

echo "🔧 Đổi dnscrypt-proxy từ port 5353 → 5300..."

# 1. Đổi port trong dnscrypt-proxy config
sed -i "s|listen_addresses = \['127.0.0.1:5353'\]|listen_addresses = ['127.0.0.1:5300']|" \
    /etc/dnscrypt-proxy/dnscrypt-proxy.toml

echo "  ✅ dnscrypt-proxy.toml → port 5300"

# 2. Cập nhật systemd-resolved config
sed -i "s|DNS=127.0.0.1#5353|DNS=127.0.0.1#5300|" \
    /etc/systemd/resolved.conf.d/dnscrypt-proxy.conf

echo "  ✅ resolved config → port 5300"

# 3. Tắt socket activation nếu có (nó sẽ conflict)
if systemctl is-enabled dnscrypt-proxy.socket &>/dev/null; then
    systemctl disable --now dnscrypt-proxy.socket
    echo "  ✅ Tắt dnscrypt-proxy.socket (tránh conflict)"
fi

# 4. Restart services
echo ""
echo "🔄 Restart services..."
systemctl restart dnscrypt-proxy
systemctl restart systemd-resolved

sleep 2

# 5. Kiểm tra
echo ""
echo "=== Trạng thái ==="
if systemctl is-active dnscrypt-proxy &>/dev/null; then
    echo "✅ dnscrypt-proxy: RUNNING"
else
    echo "❌ dnscrypt-proxy: FAILED"
    journalctl -u dnscrypt-proxy -n 5 --no-pager
    exit 1
fi

echo ""
echo "=== Port 5300 ==="
ss -tlunp | grep 5300 && echo "✅ Đang listen trên port 5300" || echo "⚠️  Chưa thấy port 5300"

echo ""
echo "=== Test DNS qua dnscrypt-proxy ==="
if command -v dig &>/dev/null; then
    RESULT=$(dig @127.0.0.1 -p 5300 google.com +short +time=5 2>/dev/null | head -1)
    if [[ -n "$RESULT" ]]; then
        echo "✅ dnscrypt-proxy DNS: google.com → ${RESULT}"
    else
        echo "⚠️  Chưa sẵn sàng (đang tải server list, đợi ~30s rồi thử lại)"
    fi
fi

echo ""
echo "=== Test DNS qua hệ thống ==="
if command -v dig &>/dev/null; then
    RESULT=$(dig google.com +short +time=5 2>/dev/null | head -1)
    if [[ -n "$RESULT" ]]; then
        echo "✅ System DNS: google.com → ${RESULT}"
    else
        echo "⚠️  System DNS chưa hoạt động qua dnscrypt-proxy"
    fi
fi

echo ""
echo "🎉 Hoàn tất!"
