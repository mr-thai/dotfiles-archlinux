#!/bin/bash
# Script mở từ điển thông minh
LANG_CODE="$1"
SOURCE_TEXT="$2"
RESULT_TEXT="$3"

# Logic: Nếu ngôn ngữ dịch (target) là VI (Tiếng Việt), thì từ gốc (SOURCE) là từ cần tra.
# Nếu ngôn ngữ nguồn là VI (Tiếng Việt), thì từ dịch (RESULT) là từ cần tra.
if [[ "$LANG_CODE" == *"VI"* ]]; then
    # Chiều EN->VI, JA->VI, ZH->VI => tra SOURCE
    TARGET_WORD="$SOURCE_TEXT"
else
    # Chiều VI->EN, VI->JA, VI->ZH => tra RESULT
    TARGET_WORD="$RESULT_TEXT"
fi

# Loại bỏ các phần không cần thiết (như chú thích Hiragana)
CLEAN_WORD=$(echo "$TARGET_WORD" | sed 's/ (.*)//' | xargs)

case "$LANG_CODE" in
    *EN*)
        xdg-open "https://www.oxfordlearnersdictionaries.com/definition/english/$(echo "$CLEAN_WORD" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')" &
        ;;
    *JA*)
        xdg-open "https://mazii.net/vi-VN/search/word/javi/$CLEAN_WORD" &
        ;;
    *ZH*)
        xdg-open "https://hanzii.net/search/word/$CLEAN_WORD?hl=vi" &
        ;;
    *)
        xdg-open "https://translate.google.com/?sl=auto&tl=vi&text=$CLEAN_WORD" &
        ;;
esac
