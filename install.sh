#!/bin/bash
set -e

echo "🚀 Bắt đầu quá trình bung cấu hình Dotfiles..."

# 1. Cài đặt các công cụ cần thiết ban đầu
echo "🛠️ Cài đặt Git và Stow..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm git stow base-devel

# 2. Cài đặt Paru (AUR Helper) nếu chưa có
if ! command -v paru &> /dev/null; then
    echo "📦 Đang cài đặt Paru..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru-install
    cd /tmp/paru-install
    makepkg -si --noconfirm
    rm -rf /tmp/paru-install
    cd ~/dotfiles
fi

# 3. Cài đặt toàn bộ phần mềm từ danh sách
if [ -f "pkglist_repo.txt" ]; then
    echo "📥 Đang cài đặt các phần mềm từ repo chính thức..."
    sudo pacman -S --needed --noconfirm - < pkglist_repo.txt
fi

if [ -f "pkglist_aur.txt" ]; then
    echo "📥 Đang cài đặt các phần mềm từ AUR..."
    paru -S --needed --noconfirm - < pkglist_aur.txt
fi

# 4. Sử dụng GNU Stow để tạo liên kết
echo "🔗 Đang tạo liên kết cấu hình bằng Stow..."
cd ~/dotfiles
# Bỏ qua các file rác hoặc README
for d in */; do
    # Bỏ qua thư mục .git
    if [[ "$d" != ".git/" ]]; then
        stow "${d%/}"
    fi
done

# 5. Đổi shell mặc định sang Zsh
echo "🐚 Đang đổi Shell mặc định sang Zsh..."
if [[ "$SHELL" != *"/zsh" ]]; then
    chsh -s $(which zsh)
fi

echo "🎉 HOÀN TẤT! Hệ thống của bạn đã được phục hồi 100%. Hãy khởi động lại máy!"
