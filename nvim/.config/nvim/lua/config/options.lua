-- ==========================================
-- CÁC CẤU HÌNH CÁ NHÂN (Ghi đè mặc định LazyVim)
-- ==========================================
vim.opt.showtabline = 0 -- Ẩn hoàn toàn tabline ở cạnh trên (vì dùng [b ]b để chuyển file)
vim.opt.swapfile = false -- Không sinh ra file rác .swp
vim.opt.scrolloff = 10 -- Giữ tối thiểu 8 dòng lề trên/dưới khi cuộn trang
-- ==========================================
-- ĐỊNH VỊ GỐC DỰ ÁN (Bỏ "lsp" so với mặc định)
-- ==========================================
vim.g.root_spec = { ".git", "lua", "cwd" }

-- ==========================================
-- AUTO-DETECT PYTHON 3 HOST (Tăng tốc nạp Python)
-- ==========================================
local python_path = vim.fn.exepath("python3")
if python_path == "" then
  python_path = vim.fn.exepath("python")
end

if python_path ~= "" then
  vim.g.python3_host_prog = python_path
end

-- ==========================================
-- DANH SÁCH TOÀN BỘ CẤU HÌNH MẶC ĐỊNH CỦA LAZYVIM
-- (Bỏ comment -- để ghi đè hoặc can thiệp trực tiếp)
-- ==========================================

-- --- Biến toàn cục (Global Variables / vim.g) ---
-- vim.g.mapleader = " "                         -- Phím Leader chính (Khoảng trắng / Space)
-- vim.g.maplocalleader = "\\"                   -- Phím Local Leader (Dấu gạch chéo ngược \)
-- vim.g.autoformat = true                       -- Tự động format code khi lưu file
-- vim.g.snacks_animate = true                   -- Bật/tắt hiệu ứng hoạt họa toàn cục cho snacks.nvim
-- vim.g.lazyvim_picker = "auto"                 -- Trình tìm kiếm mặc định: "auto", "telescope", "fzf", "snacks"
-- vim.g.lazyvim_cmp = "auto"                    -- Bộ hoàn thành mã nguồn mặc định: "auto", "nvim-cmp", "blink.cmp"
-- vim.g.ai_cmp = true                           -- Tích hợp gợi ý AI trực tiếp vào menu completion thay vì gợi ý ảo
-- vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" } -- Thứ tự ưu tiên nhận diện thư mục gốc của dự án
-- vim.g.root_lsp_ignore = { "copilot" }         -- Danh sách LSP server bị bỏ qua khi tính toán thư mục gốc
-- vim.g.deprecation_warnings = false            -- Tắt cảnh báo các hàm/API bị deprecated trong Neovim
-- vim.g.trouble_lualine = true                  -- Hiển thị vị trí symbol hiện tại từ Trouble trên lualine
-- vim.g.markdown_recommended_style = 0          -- Tắt cấu hình thụt lề 4-space mặc định của Neovim cho Markdown

-- --- Tuỳ chọn trình soạn thảo (Editor Options / vim.opt) ---
-- local opt = vim.opt
-- opt.autowrite = true                          -- Tự động lưu buffer khi mất focus hoặc chuyển buffer
-- opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- Đồng bộ clipboard hệ thống (hỗ trợ OSC 52 qua SSH)
-- opt.completeopt = "menu,menuone,noselect"     -- Cấu hình popup menu gợi ý hoàn thành code
-- opt.conceallevel = 2                          -- Ẩn ký tự markup (bold/italic) trừ khi con trỏ ở dòng đó
-- opt.confirm = true                            -- Xác nhận lưu thay đổi trước khi đóng buffer chưa lưu
-- opt.cursorline = true                         -- Làm nổi bật dòng hiện tại nơi con trỏ đang đứng
-- opt.expandtab = true                          -- Chuyển đổi phím Tab thành các ký tự khoảng trắng (spaces)
-- opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " } -- Ký tự giao diện đặc biệt
-- opt.foldlevel = 99                            -- Mở sẵn tất cả các khối nếp gấp code khi mở file
-- opt.foldmethod = "indent"                     -- Phương pháp thu gọn code dựa theo mức thụt đầu dòng
-- opt.foldtext = ""                             -- Giữ nguyên highlight cú pháp của dòng đầu khi gấp code
-- opt.formatexpr = "v:lua.LazyVim.format.formatexpr()" -- Hàm xử lý định dạng khi nhấn phím gq
-- opt.formatoptions = "jcroqlnt"                -- Quy tắc tự động định dạng và bẻ dòng văn bản/comment
-- opt.grepformat = "%f:%l:%c:%m"                -- Định dạng kết quả tìm kiếm cho lệnh :grep (ripgrep)
-- opt.grepprg = "rg --vimgrep"                  -- Sử dụng ripgrep làm công cụ tìm kiếm nội dung file
-- opt.ignorecase = true                         -- Bỏ qua phân biệt chữ hoa/chữ thường khi tìm kiếm
-- opt.inccommand = "nosplit"                    -- Xem trước kết quả thay thế chuỗi trực tiếp trên buffer
-- opt.jumpoptions = "view"                      -- Giữ nguyên vị trí cuộn màn hình khi nhảy qua jumplist
-- opt.laststatus = 3                            -- Dùng thanh trạng thái toàn cục duy nhất (global statusline)
-- opt.linebreak = true                          -- Ngắt dòng tại ranh giới từ khi bật wrap
-- opt.list = true                               -- Hiển thị các ký tự ẩn (dấu tab, khoảng trắng thừa)
-- opt.mouse = "a"                               -- Bật hỗ trợ chuột trong tất cả các chế độ
-- opt.number = true                             -- Hiển thị số dòng tuyệt đối ở lề trái
-- opt.pumblend = 10                             -- Độ trong suốt của popup menu completion (10%)
-- opt.pumheight = 10                            -- Số lượng mục tối đa hiển thị trong popup menu
-- opt.relativenumber = true                     -- Hiển thị số dòng tương đối so với dòng hiện tại
-- opt.ruler = false                             -- Tắt thước đo tọa độ dòng/cột mặc định ở góc dưới
-- opt.scrolloff = 4                             -- Luôn giữ tối thiểu 4 dòng lề trên/dưới khi cuộn trang
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } -- Thành phần lưu trong session
-- opt.shiftround = true                         -- Làm tròn mức thụt lề về bội số gần nhất của shiftwidth
-- opt.shiftwidth = 2                            -- Kích thước mỗi cấp độ thụt đầu dòng (2 spaces)
-- opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Rút gọn các thông báo hệ thống
-- opt.showmode = false                          -- Ẩn thông báo chế độ mặc định vì lualine đã hiển thị
-- opt.sidescrolloff = 8                         -- Giữ tối thiểu 8 cột lề trái/phải khi cuộn ngang
-- opt.signcolumn = "yes"                        -- Luôn hiển thị cột biểu tượng (git signs, lsp diagnostics)
-- opt.smartcase = true                          -- Tìm kiếm thông minh: phân biệt hoa thường khi có chữ hoa
-- opt.smartindent = true                        -- Tự động thụt đầu dòng thông minh theo cú pháp
-- opt.smoothscroll = true                       -- Bật cuộn mượt cho các dòng dài bị wrap
-- opt.spelllang = { "en" }                      -- Ngôn ngữ kiểm tra chính tả mặc định (tiếng Anh)
-- opt.splitbelow = true                         -- Mở cửa sổ chia ngang mới ở phía dưới
-- opt.splitkeep = "screen"                      -- Giữ nguyên vị trí dòng hiển thị trên màn hình khi split
-- opt.splitright = true                         -- Mở cửa sổ chia dọc mới ở phía bên phải
-- opt.statuscolumn = [[%!v:lua.LazyVim.statuscolumn()]] -- Cột trạng thái lề trái tùy biến của LazyVim
-- opt.tabstop = 2                               -- Số lượng khoảng trắng tương ứng với 1 ký tự Tab
-- opt.termguicolors = true                      -- Bật hỗ trợ màu 24-bit True Color trong terminal
-- opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Thời gian chờ phím tắt trước khi mở which-key (300ms)
-- opt.undofile = true                           -- Lưu lịch sử undo ra file trên đĩa để khôi phục sau khi mở lại
-- opt.undolevels = 10000                        -- Số lượng bước thay đổi tối đa có thể undo được lưu trữ
-- opt.updatetime = 200                          -- Thời gian chờ 200ms trước khi kích hoạt CursorHold và ghi swap
-- opt.virtualedit = "block"                     -- Cho phép di chuyển con trỏ vào khoảng trống ảo trong Visual Block
-- opt.wildmode = "longest:full,full"            -- Chế độ tự động hoàn thành trên Command-line
-- opt.winminwidth = 5                           -- Chiều rộng tối thiểu của một cửa sổ split (5 cột)
-- opt.wrap = false                              -- Tắt tự động xuống dòng giả lập cho các dòng văn bản dài
