# 🚀 Neovim Custom Keymaps Cheat Sheet

Đây là danh sách tổng hợp toàn bộ các phím tắt do chính bạn cấu hình trong hệ thống Neovim (đã loại bỏ các phím rườm rà mặc định của LazyVim).

## 1. 🌲 Nvim-Surround (Thao tác Ngoặc / Dấu nháy)
- `ys{chuyển_động}{dấu}`: **Bọc (Add)**. VD: `ysiw"` (bọc từ hiện tại bằng `""`), `ysiw(` (bọc bằng `()`).
- `ds{dấu}`: **Xóa (Delete)**. VD: `ds"` (xóa dấu nháy kép đang bọc), `ds{` (xóa ngoặc nhọn).
- `cs{dấu_cũ}{dấu_mới}`: **Đổi (Change)**. VD: `cs"'` (đổi `""` sang `''`), `cs({` (đổi `()` sang `{}`).

## 2. 🦘 Bộ di chuyển nhạy bén (Spider & Flash)
- `w`, `e`, `b`: Nhảy từng từ thông minh theo chuẩn *camelCase* hoặc *snake_case* (Spider).
- `s`: Kích hoạt **Flash Jump**. Gõ `s` + 2 chữ cái bất kỳ trên màn hình để bay lập tức tới đó.
- `S`: Kích hoạt **Flash Treesitter**. Bôi đen toàn bộ một khối code thông minh theo cấu trúc.

## 3. 🚀 Các phím Function (F) Khởi chạy Nhanh
- `F1`: Mở cây thư mục (Snacks Explorer).
- `F2`: Mở tìm kiếm tài liệu lập trình Offline (DevDocs).
- `F3`: Mở giao diện Lazygit thả nổi.
- `F11`: Chèn comment `FIXME:` xuống dòng dưới.
- `F12`: Chèn comment `TODO:` xuống dòng dưới.

## 4. 🔍 Tìm kiếm & Sửa lỗi (Telescope / Snacks / Trouble)
- `<Space> s g`: Live Grep (Tìm kiếm text toàn dự án).
- `<Space> s t`: Tìm kiếm mọi dòng có `TODO` hoặc `FIXME`.
- `<Space> c x`: Mở danh sách Lỗi/Cảnh báo (Diagnostics).
- `<Space> c s`: Xem các file/dòng code đang gọi đến hàm này (Usages/References).
- `<Space> U`: Xem cây Lịch sử khôi phục (Telescope Undo).

## 5. 🧰 Công cụ cho Golang (`<Space> g`)
Dành riêng cho file `.go`:
- `<Space> g t`: Chạy toàn bộ Test.
- `<Space> g T`: Chạy Test cho file hiện tại.
- `<Space> g c v`: Hiển thị độ phủ code (Coverage).
- `<Space> g a t`: Tự động thêm Struct Tags (vd: json).
- `<Space> g f s`: Điền tự động các field còn thiếu cho Struct.
- `<Space> g i e`: Tự động sinh ra khối `if err != nil { ... }`.
- `<Space> g i m`: Implement một Interface nhanh chóng.

## 6. 🐍 Công cụ cho Python (`<Space> i`)
Dành riêng cho file `.py`:
- `<Space> i`: Import thư viện cho cái hàm/biến dưới con trỏ.
- `<Space> u I`: Tự động Import TẤT CẢ các thư viện còn thiếu.

## 7. 📚 Đọc tài liệu (DevDocs)
- `g h`: Đọc tài liệu Document cho từ khóa ngay dưới con trỏ.
- `<Space> u d i`: Install thêm tài liệu Offline.
- `<Space> u d u`: Uninstall tài liệu.

## 8. 🪟 Quản lý Cửa sổ & File
- `Ctrl` + `h/j/k/l`: Nhảy qua lại giữa các Split Windows.
- `Ctrl` + `Lên/Xuống/Trái/Phải`: Chỉnh kích thước (Resize) cửa sổ.
- `[ b` / `] b`: Nhảy sang tab File (Buffer) Trái / Phải.
- `<Space> b d`: Đóng file hiện tại (không làm vỡ Layout).
- `<Space> c R`: Đổi tên file.

## 9. 📝 Các thao tác Gõ & Di chuyển cốt lõi
- `K` / `J` *(Trong Visual Mode)*: Bưng nguyên một khối code di chuyển lên/xuống.
- `Ctrl + d` / `Ctrl + u`: Cuộn trang mượt (Luôn giữ con trỏ ở giữa).
- `Ctrl + h` / `Ctrl + l` *(Trong Insert Mode)*: Dịch chuyển con trỏ sang trái/phải 1 ký tự (không cần cụm phím mũi tên).
- `Ctrl + w` *(Trong Insert Mode)*: Xóa lùi lại 1 từ phía trước.
- `<Space> <Space>` *(Trong Insert Mode)*: Tự động lưu 1 điểm Undo (tránh xóa nhầm cả đoạn dài).
- `U` (Shift + u): Redo (Làm lại thao tác vừa Undo).
- `Esc Esc` *(Trong cửa sổ Nvim Terminal)*: Thoát chế độ gõ của Terminal.

---
💡 **Mẹo:** Bất cứ khi nào quên, hãy bấm `<Space> ?` để xem danh sách phím.
