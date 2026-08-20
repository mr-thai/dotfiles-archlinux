return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, {
        { "<leader>G", hidden = true },
        { "<leader>U", hidden = true },
        { "<leader>su", hidden = true },
        { "<leader>d", hidden = true },
        { "<leader>L", hidden = true },
        { "<leader>S", hidden = true },
        { "<leader>.", hidden = true },
        { "<leader><tab>", hidden = true },
        { "<leader>qq", hidden = true },
        { "<leader>ft", hidden = true },
        { "<leader>fT", hidden = true },
        { "<C-/>", hidden = true },
        { "<c-_>", hidden = true },
        { "<leader>K", hidden = true }, -- Keywordprg
        { "<leader>E", hidden = true }, -- Explorer (cwd) (đã có e là đủ)
        { "<leader>,", hidden = true }, -- Switch Buffer (đã có [b ]b)
        { "<leader>`", hidden = true }, -- Switch Other Buffer
        { "<leader>:", hidden = true }, -- Command History
         -- Buffer Keymaps
         -- Notification History
        { "<leader>w", hidden = true }, -- Windows menu
        
        { "<leader>bD", hidden = true },
        { "<leader>bi", hidden = true },
        
                { "<leader>cf", hidden = true },
        { "<leader>ch", hidden = true },

        { "<leader>gB", hidden = true },
        { "<leader>gc", hidden = true },
                { "<leader>gf", hidden = true },
        { "<leader>gG", hidden = true },
        { "<leader>gl", hidden = true },
        { "<leader>gL", hidden = true },
                                { "<leader>gY", hidden = true },

        
        { "<leader>x", hidden = true },

                                                                                                                        { "<leader>sP", hidden = true },
                        { "<leader>sM", hidden = true },
        { "<leader>so", hidden = true },
                        { "<leader>sT", hidden = true },
                { "<leader>s\"", hidden = true },
        
        { "<leader>uA", hidden = true },
        { "<leader>uD", hidden = true },
        { "<leader>ud", hidden = true },
        { "<leader>ug", hidden = true },
        { "<leader>uG", hidden = true },
        { "<leader>ui", hidden = true },
        { "<leader>uI", hidden = true },
        { "<leader>ul", hidden = true },
        { "<leader>uL", hidden = true },
                { "<leader>up", hidden = true },
        { "<leader>ur", hidden = true },
        { "<leader>uS", hidden = true },
        { "<leader>uT", hidden = true },
        { "<leader>uH", hidden = true },
        { "<leader>us", hidden = true },
        { "<leader>uw", hidden = true },
        { "<leader>uz", hidden = true },
        { "<leader>uZ", hidden = true },

        { "<leader>e", hidden = true },
        { "<leader><space>", desc = "Files" },
        { "<leader>/", hidden = true },
        { "<leader>sw", desc = "Word" },

        { "<leader>u", group = "+System / Update", icon = "" },
        { "<leader>ua", desc = "Toggle AI (Copilot)", icon = "" },

        { "<leader>sa", desc = "Noice All" },
        { "<leader>sl", desc = "Noice Last Message" },

        { "<leader>cm", hidden = true },
                { "<leader>cS", hidden = true },
        { "<leader>cf", hidden = true },
        { "<leader>ch", hidden = true },
                { "<leader>on", hidden = true },
        { "<leader>os", hidden = true },
        { "<leader>cg", hidden = true },
        { "<leader>cd", hidden = true },
                
        { "<leader>ss", desc = "Symbol" },
        { "<leader>sS", desc = "Global Symbol" },
        { "<leader>fc", hidden = true }, -- Config Files (đã xoá)
                { "<leader>uF", hidden = true },

        { "<F2>", desc = "Lazygit", icon = "󰊢" },

        -- ========================================
        -- 📚 TỪ ĐIỂN 100% PHÍM TẮT (DÙNG ĐỂ ẨN TRONG WHICH-KEY)
        -- Bỏ comment (xoá `-- `) ở đầu dòng để Ẩn phím khỏi menu.
        -- ========================================

        -- ⚙️ Hệ thống & Giao diện
        -- { "<leader>?", hidden = true }, -- Xem phím tắt của file hiện tại
        -- { "<leader>dps", hidden = true }, -- Xem hiệu năng (Profiler)
        -- { "<leader>sa", hidden = true }, -- Danh sách Autocmd (đã đổi sang Noice All)
        { "<leader>sh", hidden = true }, -- Tìm trang trợ giúp (Help)
        -- { "<leader>si", hidden = true }, -- Bảng chọn Icon
        -- { "<leader>sk", hidden = true }, -- Xem tất cả phím tắt
        -- { "<leader>sM", hidden = true }, -- Tìm trang Man
        -- { "<leader>uC", hidden = true }, -- Đổi giao diện (Theme)

        -- 📁 File & Buffer
        { "<leader>bd", hidden = true }, -- Đóng Tab hiện tại
        { "<leader>cR", hidden = true }, -- Đổi tên file
        { "<leader>fB", hidden = true }, -- Tất cả Tab
        { "<leader>fb", hidden = true }, -- Danh sách Tab đang mở
        -- { "<leader>fc", hidden = true }, -- Tìm file cấu hình (Neovim) (đã ẩn ở dòng <leader>fc)
        { "<leader>fE", hidden = true }, -- Mở thanh quản lý File (Thư mục hiện tại)
        { "<leader>fe", hidden = true }, -- Mở thanh quản lý File (Gốc dự án)
        { "<leader>fF", hidden = true }, -- Tìm file (Thư mục hiện tại)
        { "<leader>ff", hidden = true }, -- Tìm file (Gốc dự án)
        { "<leader>fg", hidden = true }, -- Tìm file trong Git
        { "<leader>fp", hidden = true }, -- Quản lý dự án (Projects)
        { "<leader>fR", hidden = true }, -- File gần đây (Thư mục hiện tại)
        { "<leader>fr", hidden = true }, -- File gần đây
        { "<leader>sb", hidden = true }, -- Tìm dòng trong file hiện tại
        -- { "[ ", hidden = true }, -- Thêm dòng trống bên trên
        -- { "] ", hidden = true }, -- Thêm dòng trống bên dưới

        -- 📝 Soạn thảo
        -- { "<C-B>", hidden = true }, -- Cuộn trang lên
        -- { "<C-F>", hidden = true }, -- Cuộn trang xuống
        { "<leader>cF", hidden = true }, -- Auto Format code nhúng
        -- { "b", hidden = true }, -- Lùi 1 từ (nhảy qua camelCase)
        -- { "e", hidden = true }, -- Tới cuối 1 từ (nhảy qua camelCase)
        -- { "gc", hidden = true }, -- Bật/Tắt Comment (Visual/Normal)
        -- { "gcc", hidden = true }, -- Bật/Tắt Comment dòng
        -- { "gx", hidden = true }, -- Mở file/URL dưới con trỏ
        -- { "s", hidden = true }, -- Nhảy siêu tốc (Flash)
        -- { "w", hidden = true }, -- Tới 1 từ (nhảy qua camelCase)

        -- 🔍 Tìm kiếm & Grep
        -- { "<leader>s\"", hidden = true }, -- Danh sách Clipboard (Registers) (đã ẩn ở trên)
        { "<leader>s/", hidden = true }, -- Lịch sử tìm kiếm
        { "<leader>sB", hidden = true }, -- Grep trong các file đang mở
        { "<leader>sC", hidden = true }, -- Danh sách lệnh
        { "<leader>sc", hidden = true }, -- Lịch sử lệnh
        { "<leader>sG", hidden = true }, -- Grep thư mục hiện tại
        -- { "<leader>sg", hidden = true }, -- Grep toàn dự án (Gốc)
        { "<leader>sH", hidden = true }, -- Tìm màu sắc/Highlight
        { "<leader>sj", hidden = true }, -- Lịch sử con trỏ (Jumps)
        -- { "<leader>sl", hidden = true }, -- Danh sách vị trí (Location List) (đã đổi sang Noice Last Message)
        { "<leader>sm", hidden = true }, -- Danh sách đánh dấu (Marks)
        { "<leader>sp", hidden = true }, -- Tìm code cấu hình của Plugin
        { "<leader>sq", hidden = true }, -- Danh sách sửa nhanh (Quickfix)
        { "<leader>sR", hidden = true }, -- Mở lại kết quả tìm kiếm gần nhất
        -- { "<leader>sW", hidden = true }, -- Tìm từ khóa dưới con trỏ (Thư mục hiện tại)
        -- { "<leader>sw", hidden = true }, -- Tìm từ khóa dưới con trỏ (Gốc dự án)

        -- 🧠 LSP & Code Navigation
        { "[D", hidden = true }, -- Nhảy đến cảnh báo/lỗi đầu tiên
        { "gO", hidden = true }, -- Danh sách Hàm/Biến trong file
        -- { "gra", hidden = true }, -- Gợi ý sửa code (Code Action)
        -- { "gri", hidden = true }, -- Nhảy đến nơi thực thi (Implementation)
        -- { "grn", hidden = true }, -- Đổi tên biến toàn cục (Rename)
        -- { "grr", hidden = true }, -- Tìm các nơi sử dụng biến (References)
        -- { "grt", hidden = true }, -- Nhảy đến định nghĩa kiểu (Type Definition)
        -- { "grx", hidden = true }, -- Chạy CodeLens

        -- 🌳 Treesitter Text Objects
        -- { "an", hidden = true }, -- Chọn node cha (Treesitter)
        -- { "in", hidden = true }, -- Chọn node con (Treesitter)

        -- 🐙 Git & Version Control
        { "<leader>gD", hidden = true }, -- Xem thay đổi Git (So với origin)
        { "<leader>gd", hidden = true }, -- Xem thay đổi Git (Hunk)
        -- { "<leader>gI", hidden = true }, -- Danh sách GitHub Issues
        { "<leader>gi", hidden = true }, -- GitHub Issues (Đang mở)
        -- { "<leader>go", hidden = true }, -- Bật/Tắt hiển thị mini.diff
        -- { "<leader>gP", hidden = true }, -- Danh sách GitHub Pull Requests
        { "<leader>gp", hidden = true }, -- GitHub PRs (Đang mở)
        { "<leader>gS", hidden = true }, -- Danh sách Git Stash
        { "<leader>gs", hidden = true }, -- Git Status

        -- 🔔 Thông báo (Noice)
        -- { "<leader>n", hidden = true }, -- Lịch sử thông báo
        { "<leader>sna", hidden = true }, -- Tất cả tin nhắn Noice (đã đổi sang <leader>sa)
        { "<leader>snl", hidden = true }, -- Tin nhắn Noice cuối (đã đổi sang <leader>sl)
        { "<leader>snd", hidden = true }, -- Xóa tất cả thông báo
        { "<leader>snh", hidden = true }, -- Lịch sử tin nhắn Noice
        { "<leader>snt", hidden = true }, -- Tìm kiếm tin nhắn Noice
        { "<leader>un", hidden = true }, -- Xóa tất cả thông báo

        -- 🧩 Khác (Mặc định Vim)
        -- { "#", hidden = true }, -- Tìm từ khóa dưới con trỏ ngược (Visual #)
        { "&", hidden = true }, -- :help &-default
        -- { "*", hidden = true }, -- Tìm từ khóa dưới con trỏ xuôi (Visual *)
        { "<C-Space>", hidden = true }, -- Treesitter Incremental Selection
        -- { "<C-W> ", hidden = true }, -- Window Hydra Mode (which-key)
        { "<C-W><C-D>", hidden = true }, -- Show diagnostics under the cursor
        { "<C-W>d", hidden = true }, -- Show diagnostics under the cursor
        { "<leader>sD", hidden = true }, -- Buffer Diagnostics
        { "<leader>sd", hidden = true }, -- Diagnostics
        { "<S-Tab>", hidden = true }, -- vim.snippet.jump if active, otherwise <S-Tab>
        { "<Tab>", hidden = true }, -- vim.snippet.jump if active, otherwise <Tab>
        { "@", hidden = true }, -- Chạy Macro (Visual)
        { "Q", hidden = true }, -- Lặp lại Macro (Q)
        { "S", hidden = true }, -- Flash Treesitter
        { "Y", hidden = true }, -- Copy đến cuối dòng (Y)

      })
    end,
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>S", false }, -- Ngăn chặn tạo Scratch Buffers
      { "<leader>.", false }, -- Ngăn chặn tạo Scratch Buffers
      { "<leader>/", false }, -- Tắt phím Grep mặc định
    }
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>/", false }, -- Tắt phím Grep mặc định
    },
  }
}
