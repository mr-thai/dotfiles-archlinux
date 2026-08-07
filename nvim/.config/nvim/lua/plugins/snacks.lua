return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
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


        -- TỐI ƯU CÂY THƯ MỤC SNACKS EXPLORER
        picker = {
            enabled = true,
            ui_select = true,
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
        -- Smooth scroll: hiệu ứng cuộn mượt khi dùng Ctrl+D/U, PageUp/Down
        -- Khác smear-cursor (trail theo con trỏ), đây là animation khi cuộn trang
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 12, total = 160 }, -- Duration ngắn, cảm giác nhanh
                easing = "linear",
            },
            -- Giữ smear-cursor (trail con trỏ), scroll chỉ phụ trách cuộn trang
            filter = function(buf)
                return vim.g.snacks_scroll ~= false
                    and vim.b[buf].snacks_scroll ~= false
                    and vim.bo[buf].buftype ~= "terminal"
            end,
        },

        -- Notifier: gọn nhỏ, icon rõ theo level
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

