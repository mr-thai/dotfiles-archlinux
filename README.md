# 🚀 Arch Linux Dotfiles Restore Guide

 Chào mừng bạn đến với kịch bản phục hồi toàn bộ sức mạnh của cỗ máy Arch Linux. 
Chỉ cần làm theo đúng trình tự dưới đây, hệ thống mới sẽ giống **100%** hệ thống cũ (ngoại trừ các token đăng nhập và cấu hình phần cứng cấp hệ thống).

## 🛠️ Trình tự bung lụa (Restore Workflow)

### Bước 1: Cài đặt công cụ nền móng
Trên máy Arch Linux mới tinh, bạn cần cài đặt Git (để clone) và GNU Stow (để link cấu hình):
```bash
sudo pacman -Syu
sudo pacman -S git stow
```

### Bước 2: Tải kho cấu hình về máy
```bash
git clone https://github.com/TEN_GITHUB_CUA_BAN/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Bước 3: Phép thuật GNU Stow (Bung cấu hình)
Tạo symlink cho toàn bộ cấu hình bằng một lệnh duy nhất:
```bash
stow */
```
*(Nếu nó báo lỗi conflict do file đã tồn tại, hãy xoá file mặc định đó đi bằng lệnh `rm` rồi chạy lại `stow */`)*

### Bước 4: Cài đặt lại toàn bộ phần mềm
Bạn không cần phải nhớ xem mình đã cài gì. Tôi đã lưu sẵn danh sách gói cho bạn.

Cài đặt các gói thuộc kho chính thức của Arch:
```bash
sudo pacman -S --needed - < pkglist_repo.txt
```

Cài đặt trình hỗ trợ AUR (ví dụ paru):
```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si
cd ~/dotfiles
```

Cài đặt các gói thuộc AUR:
```bash
paru -S --needed - < pkglist_aur.txt
```

### Bước 5: Đổi Shell mặc định sang Zsh
Hệ thống cũ của bạn dùng Zsh làm môi trường chính. Hãy chuyển sang Zsh để tải các plugin và tự động mở Zellij:
```bash
chsh -s $(which zsh)
```

### Bước 6: Các thao tác thủ công (Bảo mật & Đăng nhập)
Cuối cùng, bạn cần phải tự tay thực hiện các bước đăng nhập sau vì chúng ta đã không đưa dữ liệu nhạy cảm lên Git:
- [ ] Đăng nhập Github CLI: `gh auth login`
- [ ] Đăng nhập lại Rclone (Google Drive / OneDrive)
- [ ] Tạo các chìa khóa SSH mới hoặc copy từ USB sang `~/.ssh/`
- [ ] Mở Neovim (`nvim`) để nó tự động tải plugins (Lazy.nvim)

Khởi động lại máy và tận hưởng thành quả! 🎉
