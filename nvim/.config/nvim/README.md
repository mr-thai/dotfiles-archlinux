# ⚔️ Neovim "Máy Chém" - Kiến Trúc Kiểm Soát Tuyệt Đối

Đây không phải là một bộ cấu hình Neovim bình thường. Đây là một hệ thống được thiết kế theo triết lý **"Máy Chém" (Guillotine)**: Mọi thứ ngầm định của LazyVim đều bị lôi ra ánh sáng, và người dùng nắm quyền sinh sát tuyệt đối đối với từng dòng code, từng phím tắt, từng hiệu ứng.

## 🌟 Triết Lý Thiết Kế
1. **Minh Bạch 100%:** Không có "phép thuật đen" (Black magic) chạy ngầm. Những gì LazyVim giấu đi đều được móc ra dưới dạng Boilerplate (Comment) để theo dõi.
2. **Kiểm Soát Tối Đa:** Ghét phím nào? Bóp mũi phím đó. Ghét plugin nào? Rút ống thở plugin đó.
3. **Phân Vùng Rõ Ràng:** Ranh giới sắc nét giữa thứ của LazyVim (Core) và thứ của mình (Custom).

---

## 📂 Cấu Trúc Thư Mục
Hệ thống Plugin được chia làm 2 thư mục rõ rệt tại `lua/plugins/`:

- 📁 `1_lazyvim/`: Chứa các cấu hình **can thiệp thẳng vào bộ ruột** của LazyVim.
  - `snacks.lua`: Quản lý Bảng điều khiển, hiệu ứng cuộn, thông báo (đã chứa từ điển tắt/bật 31 module).
  - `mason.lua` / `lsp.lua`: Nắm đầu các máy chủ ngôn ngữ (LSP), Linter, Formatter.
  - `disabled_plugins.lua`: **Nghĩa trang Plugin**. Chứa danh sách 100% plugin của LazyVim. Muốn tắt plugin nào, chỉ việc bỏ comment.
  
- 📁 `2_custom/`: Chứa các Plugin và cấu hình **mang tính cá nhân** của riêng bạn.
  - `clean_menu.lua`: Quản lý giao diện Which-Key (Đổi tên, đổi icon, hoặc tàng hình phím).
  - `kill_keys.lua`: Triệt tiêu tận gốc các phím tắt cứng đầu được nhúng sâu vào mã nguồn của plugin.

---

## 🎹 Cẩm Nang Xử Lý Phím Tắt

Hệ thống cung cấp một **Từ điển 100% phím tắt đang hoạt động** nằm rải rác ở 2 file. Hãy làm theo lưu đồ sau khi muốn xử lý một phím:

### 1. Muốn Phím CHẾT THẬT (Nhấn vào vô tác dụng)
👉 Mở file `lua/config/keymaps.lua`
- Cuộn xuống dưới cùng, tìm khu vực `-- 📚 TỪ ĐIỂN 100% PHÍM TẮT (DÙNG ĐỂ XOÁ)`.
- Xoá dấu comment `-- ` ở dòng chứa phím đó.
- *Hệ thống Autocmd "LazyDone" sẽ tự động truy sát và xoá phím này ngay khi Neovim khởi động xong.*

### 2. Muốn Phím TÀNG HÌNH (Vẫn bấm được nhưng ẩn khỏi menu cho đỡ rối)
👉 Mở file `lua/plugins/2_custom/clean_menu.lua`
- Tìm khu vực `-- 📚 TỪ ĐIỂN 100% PHÍM TẮT (DÙNG ĐỂ ẨN TRONG WHICH-KEY)`.
- Xoá dấu comment `-- ` (thuộc tính `hidden = true` sẽ kích hoạt).

### 3. Muốn Đổi Tên / Đổi Icon cho Phím
👉 Mở `lua/plugins/2_custom/clean_menu.lua`
- Sửa lại tuỳ chọn: `{ "<leader>abc", desc = "Tên Mới Của Tôi", icon = "🚀" }`.

### 4. Muốn ĐỔI Phím Tắt (Ví dụ: Đổi `<leader>snn` thành `<leader>sn`)
Nếu bạn thấy phím mặc định quá dài hoặc khó bấm, bạn cần thực hiện 2 bước (Giết cũ - Lập mới):
1. **Giết phím cũ:** Mở `lua/config/keymaps.lua`, đưa phím cũ (vd: `{ "n", "<leader>snn" }`) vào danh sách `keys_to_delete`.
2. **Khai sinh phím mới:** Cũng trong file `lua/config/keymaps.lua` (ở nửa trên), tự tạo phím mới và gọi lại lệnh gốc. Ví dụ:
   ```lua
   vim.keymap.set("n", "<leader>sn", "<cmd>Lệnh_Gì_Đó<cr>", { desc = "Mô tả của bạn" })
   ```
*(Mẹo: Bạn có thể tra lệnh gốc `<cmd>...` của phím cũ bằng cách gõ `:map <leader>snn` trước khi giết nó).*


---

## ⚙️ Cẩm Nang Quản Lý Cài Đặt Ngầm

LazyVim mặc định set rất nhiều tuỳ chọn (Options) và sự kiện (Autocmds). Chúng tôi đã lôi cổ tất cả chúng ra dưới dạng Comment.

- **Tuỳ chọn (Options):** Mở `lua/config/options.lua`. Nếu bạn thấy một behavior nào lạ (như tự cuộn trang, tự wrap chữ, giấu markdown), hãy xuống cuối file, tìm tuỳ chọn tương ứng, bỏ comment và set nó về giá trị bạn muốn (ví dụ `vim.opt.wrap = false`).
- **Sự kiện ngầm (Autocmds):** Mở `lua/config/autocmds.lua`. Các lệnh `vim.api.nvim_del_augroup_by_name("lazyvim_xxx")` đã nằm sẵn ở dưới. Bỏ comment để tiêu diệt các sự kiện như tự động resize cửa sổ, chớp sáng màn hình, v.v.

---

## 💡 Lưu Ý Quan Trọng
- Để có cái nhìn tổng quan dạng bảng đẹp mắt về các phím đang dùng, hãy mở file Markdown trong Obsidian: `ObsidianDrive/Obsidian_Backup/00 Inbox/keyboard/nvim - keymap basic 1.md`.
- Hệ thống này ưu tiên **chất lượng hơn số lượng**. Thứ gì không hiểu, không dùng 👉 Đưa lên "Máy chém"!
