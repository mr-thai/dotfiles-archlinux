#!/bin/bash
# fix-dnscrypt-config.sh
# Sửa lỗi cert_refresh_delay nằm sai vị trí trong TOML
# Chạy: sudo bash fix-dnscrypt-config.sh

set -euo pipefail

CONF="/etc/dnscrypt-proxy/dnscrypt-proxy.toml"

# Xóa block cert_refresh_delay cũ (ở cuối file, sau [nx_log])
sed -i '/^# ── Đo hiệu suất server định kỳ/,/^cert_refresh_delay/d' "$CONF"

# Thêm cert_refresh_delay vào đúng vị trí (sau lb_estimator, trước cache)
sed -i '/^lb_estimator = true$/a\\n# Tự benchmark lại server mỗi 240 giây\n# Server nào chậm sẽ bị loại, server nhanh được ưu tiên\ncert_refresh_delay = 240' "$CONF"

# Xóa dòng trống thừa cuối file
sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$CONF"

echo "✅ Đã sửa config"
echo ""
echo "Đang restart dnscrypt-proxy..."
systemctl restart dnscrypt-proxy

sleep 2

echo ""
echo "=== Trạng thái service ==="
systemctl is-active dnscrypt-proxy && echo "✅ dnscrypt-proxy đang chạy!" || echo "❌ Vẫn lỗi, chạy: journalctl -u dnscrypt-proxy -n 20"

echo ""
echo "=== Test DNS ==="
if command -v dig &>/dev/null; then
    RESULT=$(dig @127.0.0.1 -p 5353 google.com +short +time=3 2>/dev/null | head -1)
    if [[ -n "$RESULT" ]]; then
        echo "✅ DNS hoạt động! google.com → ${RESULT}"
    else
        echo "⚠️  DNS chưa sẵn sàng, đợi ~30s rồi thử: dig @127.0.0.1 -p 5353 google.com"
    fi
fi
