return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        image = { enabled = true },
        profiler = { enabled = true },
        lazygit = { enabled = true }, -- Git UI trong floating window
        animate = { enabled = false }, -- TẮT HOÀN TOÀN HIỆU ỨNG ĐUÔI CON TRỎ

        -- ==========================================
        -- DANH MỤC TOÀN BỘ CÁC MODULE CỦA SNACKS.NVIM
        -- (Bỏ comment và đổi true/false để can thiệp / bật tắt từng module)
        -- ==========================================
        -- animate = { enabled = false },      -- Hiệu ứng animation con trỏ & chuyển động mượt mà
        -- bigfile = { enabled = true },       -- Tự động vô hiệu hoá plugin nặng khi mở file dung lượng lớn
        -- bufdelete = { enabled = true },     -- Đóng buffer nhanh chóng mà không làm vỡ bố cục chia cửa sổ
        -- dashboard = { enabled = false },    -- Màn hình khởi động chào mừng (Dashboard với banner & phím tắt)
        -- debug = { enabled = true },         -- Bộ công cụ inspect & debug biến/bảng cho lập trình viên Lua
        -- dim = { enabled = true },           -- Làm mờ các đoạn code nằm ngoài phạm vi con trỏ hoặc window không focus
        -- explorer = { enabled = true },      -- Trình quản lý cây thư mục file explorer (thay thế Neo-tree)
        -- gh = { enabled = true },            -- Tích hợp GitHub CLI để duyệt và chỉnh sửa Issues, Pull Requests
        -- git = { enabled = true },           -- Tiện ích tương tác Git cơ bản (root repo, diff, status, log)
        -- gitbrowse = { enabled = true },     -- Mở nhanh link file, dòng mã, commit hoặc PR trên trình duyệt web
        -- health = { enabled = true },        -- Module kiểm tra sức khỏe và tương thích hệ thống (:checkhealth snacks)
        -- image = { enabled = true },         -- Xem trước và render ảnh/PDF/Mermaid trực tiếp trong terminal
        -- indent = { enabled = true },        -- Hiển thị các đường gióng dẫn hướng thụt lề (indent guides)
        -- input = { enabled = true },         -- Hộp thoại nhập dữ liệu (input UI) nổi hiện đại thay vim.ui.input
        -- layout = { enabled = true },        -- Bộ quản lý bố cục nâng cao cho các cửa sổ nổi (floating layouts)
        -- lazygit = { enabled = true },       -- Mở giao diện LazyGit trong floating window đồng bộ giao diện
        -- notifier = { enabled = true },      -- Hệ thống thông báo toast thông minh thay thế nvim-notify
        -- notify = { enabled = true },        -- Cầu nối chuyển hướng vim.notify sang notifier
        -- picker = { enabled = true },        -- Bộ tìm kiếm mờ (Fuzzy Finder) file, grep, symbol siêu tốc
        -- profiler = { enabled = true },      -- Đo thời gian tải plugin và hiệu năng khởi động Neovim
        -- quickfile = { enabled = true },     -- Tối ưu hiển thị nội dung file ngay lập tức trước khi nạp plugin
        -- rename = { enabled = true },        -- Đổi tên biến LSP tại chỗ và đổi tên file tự động cập nhật import
        -- scope = { enabled = true },         -- Làm nổi bật phạm vi khối mã hiện tại (thay thế mini.indentscope)
        -- scratch = { enabled = true },       -- Mở nhanh buffer ghi chú nháp tạm thời (scratchpad)
        -- scroll = { enabled = true },        -- Hiệu ứng cuộn trang mượt mà (smooth scrolling)
        -- statuscolumn = { enabled = true },  -- Cột lề trái hiển thị số dòng, git diff, diagnostic icons, folds
        -- terminal = { enabled = true },      -- Trình quản lý terminal tích hợp hỗ trợ điều hướng thông minh
        -- toggle = { enabled = true },        -- Bộ công cụ tạo phím tắt bật/tắt nhanh các thiết lập
        -- win = { enabled = true },           -- Bộ quản lý cửa sổ nổi và popup (floating windows)
        -- words = { enabled = true },         -- Tự động highlight và điều hướng các từ/biến giống nhau dưới con trỏ
        -- zen = { enabled = true },           -- Chế độ tập trung (Zen Mode) căn giữa văn bản và ẩn thanh công cụ phụ

        picker = {
            enabled = true,
            ui_select = true,
            win = {
                input = {
                    keys = {
                        ["J"] = { "preview_scroll_down", mode = { "n" } }, -- Scroll preview down (Cuộn tài liệu xuống)
                        ["K"] = { "preview_scroll_up",   mode = { "n" } }, -- Scroll preview up (Cuộn tài liệu lên)
                    },
                },
                list = {
                    keys = {
                        ["J"] = { "preview_scroll_down", mode = { "n" } }, -- Scroll preview down (Cuộn tài liệu xuống)
                        ["K"] = { "preview_scroll_up",   mode = { "n" } }, -- Scroll preview up (Cuộn tài liệu lên)
                    },
                },
            },
            layouts = {
                -- Override telescope layout to vertical for better reading (Đổi bố cục telescope thành dọc để đọc tài liệu dễ hơn)
                telescope = {
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        width = 0.9,  -- Chiều rộng chiếm 90% màn hình
                        height = 0.95, -- Chiều cao chiếm 95% màn hình
                        { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                        { win = "list", border = "rounded", height = 10 }, -- Danh sách kết quả chỉ chiếm 10 dòng
                        { win = "preview", title = "{preview}", border = "rounded" }, -- Nội dung chiếm toàn bộ phần còn lại
                    },
                },
            },
            sources = {
                explorer = {
                    hidden = false,  -- Ẩn file chấm ngầm định
                    ignored = false, -- Ẩn file trong .gitignore (node_modules, v.v...)
                    layout = {
                        layout = {
                            position = "left", -- Đặt nó ở mép trái theo ý bạn
                        },
                    },
                },
            },
        },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 12, total = 160 }, -- Duration ngắn, cảm giác nhanh
                easing = "linear",
            },
            filter = function(buf)
                return vim.g.snacks_scroll ~= false
                    and vim.b[buf].snacks_scroll ~= false
                    and vim.bo[buf].buftype ~= "terminal"
            end,
        },

        notifier = {
            enabled = true,
            timeout = 3500,
            width  = { min = 16, max = 0.25 },      -- Khung nhỏ hơn: tối đa 25% màn hình
            height = { min = 1,  max = 0.12 },      -- Chiều cao tối thiểu, co lại theo nội dung
            margin = { top = 1, right = 1, bottom = 0 },
            padding = false,                         -- Bỏ padding để gọn hơn
            sort = { "level", "added" },
            level = vim.log.levels.TRACE,
            icons = {
                error = "󰅚 ",
                warn  = "󰀪 ",
                info  = "󰋽 ",
                debug = "󰃤 ",
                trace = "󰔱 ",
            },
            style = "compact",  -- Gọn nhất: icon + text, không title bar
            top_down = true,
        },

        styles = {
            notification = {
                border = "rounded",                  -- Khung viền bo tròn
                wo = { wrap = true, winblend = 15 },
            },
            notification_history = {
                border = "rounded",
                title = "  Notification History",
                title_pos = "center",
            },
        },

    },
    keys = {
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>nd", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
        { "<leader>bd", function() Snacks.bufdelete() end,             desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
        { "<leader>dC", function() Snacks.profiler.scratch() end,      desc = "Profiler Scratch" },
    },
}

