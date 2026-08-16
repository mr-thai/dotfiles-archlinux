#!/bin/bash
TEXT="$1"
LANG="${2:-en}"

if [ -z "$TEXT" ]; then
    exit 0
fi

# Chuyển mã ngôn ngữ (VD: EN-US -> en, JA -> ja, ZH -> zh, VI -> vi)
LANG_CODE=$(echo "$LANG" | tr '[:upper:]' '[:lower:]' | cut -d'-' -f1)

# Lọc bỏ phần Hiragana trong ngoặc đơn nếu có (để phát âm tiếng Nhật chuẩn)
CLEAN_TEXT=$(echo "$TEXT" | sed 's/ (.*)//')

# Trích xuất URL encoded
ENCODED_TEXT=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$CLEAN_TEXT")

# Dừng audio TTS trước đó nếu đang chạy và phát audio mới
pkill -f "translate_tts" 2>/dev/null || true
mpv --really-quiet "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=${LANG_CODE}&q=${ENCODED_TEXT}" &
