#!/bin/bash

# Close old processes
for pid in $(pgrep -f "ocr_translate.sh"); do
    if [ $pid != $$ ]; then
        kill -9 $pid 2>/dev/null
    fi
done

# Select screen region (slurp creates green border, semi-transparent background)
IMAGE_PATH="/tmp/ocr_capture.png"
REGION=$(slurp -b 00000080 -c a6e3a1 -w 2 2>/dev/null)

# If user presses Esc to cancel selection, exit
if [ -z "$REGION" ]; then
    exit 0
fi

# Capture selected region
grim -g "$REGION" "$IMAGE_PATH" || exit 1

# Show Eww notification for reading image
eww update dict_word="🔍 Reading image..." dict_meaning="Scanning text with AI (OCR)..."
eww open dict_popup 2>/dev/null || true

# Run Tesseract OCR (English recognition)
tesseract "$IMAGE_PATH" /tmp/ocr_result -l eng 2>/dev/null
TEXT=$(cat /tmp/ocr_result.txt 2>/dev/null)

# Delete image and temporary text file
rm -f "$IMAGE_PATH" /tmp/ocr_result.txt

if [ -z "$TEXT" ]; then
    eww update dict_word="❌ No text found" dict_meaning="The selected region contains no English text."
    sleep 3
    eww close dict_popup
    exit 0
fi

# Remove extra newlines from incorrect OCR wrapping, limit to 1000 characters
TEXT=$(echo "$TEXT" | tr '\n' ' ' | sed -e 's/  */ /g' | xargs)
TEXT=${TEXT:0:1000}

eww update dict_word="$TEXT" dict_meaning="⏳ Translating..."

# Call translate-shell to translate
MEANING=$(timeout 5s trans -no-ansi -b -t vi "$TEXT" 2>/dev/null)

if [ $? -eq 124 ]; then
    MEANING="⏳ Translation timeout."
elif [ -z "$MEANING" ]; then
    MEANING="❌ Network error."
fi

eww update dict_meaning="$MEANING"

# Close after 15 seconds because OCR sentences are usually long
sleep 15
eww close dict_popup
