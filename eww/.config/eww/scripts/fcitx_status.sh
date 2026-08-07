#!/bin/bash

engine=$(fcitx5-remote -n 2>/dev/null)
if [ -z "$engine" ]; then
    engine="keyboard-us"
fi

case "$engine" in
    unikey|bamboo|vni)
        text="🇻🇳 VI"
        tooltip="Input Method: Vietnamese ($engine)"
        class="lang-vi"
        ;;
    keyboard-us|keyboard-us-intl)
        text="🇺🇸 EN"
        tooltip="Keyboard Layout: English (US)"
        class="lang-en"
        ;;
    pinyin|rime|chewing|sogoupinyin|sogou-pinyin)
        text="🇨🇳 ZH"
        tooltip="Input Method: Chinese ($engine)"
        class="lang-zh"
        ;;
    anthy|mozc)
        text="🇯🇵 JP"
        tooltip="Input Method: Japanese"
        class="lang-jp"
        ;;
    hangul)
        text="🇰🇷 KR"
        tooltip="Input Method: Korean"
        class="lang-kr"
        ;;
    *)
        lang_code=$(echo "$engine" | sed -E 's/keyboard-//g' | cut -c1-2 | tr '[:lower:]' '[:upper:]')
        text="🌐 $lang_code"
        tooltip="Keyboard Layout: $engine"
        class="lang-generic"
        ;;
esac

echo "{\"text\":\"$text\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"
