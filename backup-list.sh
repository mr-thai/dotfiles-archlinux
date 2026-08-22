DOTFILES_DIR="$(dirname "$(realpath "$0")")/.."

echo "Syncing repo packages..."
pacman -Qqen >"$DOTFILES_DIR/pkglist_repo.txt"
echo "  → $(wc -l <"$DOTFILES_DIR/pkglist_repo.txt") packages"

echo "Syncing AUR packages..."
pacman -Qqm >"$DOTFILES_DIR/pkglist_aur.txt"
echo "  → $(wc -l <"$DOTFILES_DIR/pkglist_aur.txt") packages"

echo "Done. Review with: git diff pkglist_*.txt"
