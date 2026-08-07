#!/bin/bash
IMG_PATH="/tmp/ocr_shot.png"
TXT_PATH="/tmp/ocr_text"

if ! grim -g "$(slurp)" "$IMG_PATH"; then
    notify-send -t 2000 "OCR" "Cancelled screenshot."
    exit 0
fi

notify-send -t 1500 "OCR" "Scanning and extracting text..."

if tesseract "$IMG_PATH" "$TXT_PATH" -l eng+vie >/dev/null 2>&1; then
    OCR_RESULT=$(sed '/^[[:space:]]*$/d' "${TXT_PATH}.txt")
    if [ -n "$OCR_RESULT" ]; then
        echo -n "$OCR_RESULT" | wl-copy
        notify-send -t 8000 "OCR Success!" "Copied text to Clipboard:\n\n$OCR_RESULT"
    else
        notify-send -t 3000 "OCR Failed" "No characters found in the selected region."
    fi
else
    notify-send -t 3000 "OCR Error" "An error occurred during text recognition."
fi
rm -f "$IMG_PATH" "${TXT_PATH}.txt"
