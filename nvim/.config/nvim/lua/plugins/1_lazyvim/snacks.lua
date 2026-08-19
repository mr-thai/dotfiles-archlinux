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

