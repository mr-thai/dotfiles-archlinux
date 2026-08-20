vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
})

vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search Next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search Prev" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })

vim.keymap.set("i", "<Space>", "<Space><c-g>u", { desc = "Undo breakpoint on Space" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Inc Height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Dec Height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Dec Width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Inc Width" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

local keys_to_delete = {
    { "n", "<leader>sM" },
    { "n", "<leader>dps" },
    { "n", "<leader>dp" },
    { "n", "<leader>a" },
    { "n", "<leader>A" },
    { "n", "]m" },
    { "n", "[m" },
    { "n", "]p" },
    { "n", "[p" },
    { "n", "<leader>su" },
    { "n", "<leader>U" },
    { "n", "]w" },
    { "n", "[w" },
    { "n", "<A-j>" },
    { "n", "<A-k>" },
    { "v", "<A-j>" },
    { "v", "<A-k>" },
    { "i", "<A-j>" },
    { "i", "<A-k>" },
    { "n", "<C-s>" },
    { "i", "<C-s>" },
    { "x", "<C-s>" },
    { "s", "<C-s>" },
    { "n", "<leader>wd" },
    { "n", "<leader>wm" },
    { "t", "<esc><esc>" },
    { "n", "<leader>st" },
    { "n", "<leader>nh" },
    { "n", "<leader>nd" },
    { "n", "<leader>dC" },
    { "n", "<leader>cs" },
    { "n", "<leader>xq" },
    { "n", "]q" },
    { "n", "[q" },
    { "n", "<leader>L" },
    { "n", "<leader>S" },
    { "n", "<leader>." },
    { "n", "<leader>qq" },
    { "n", "<leader>cm" },
    { "n", "<leader>cR" },
    { "n", "<leader>cS" },
    { "n", "<leader>E" },
    { "n", "<leader>e" },
    { "n", "<leader>fc" },
    { "n", "<leader>fn" },
    { "n", "<leader>fp" },
    { "n", "<leader>fr" },
    { "n", "<leader>f" },
    { "n", "<leader>uz" },
    { "n", "<leader>sB" },
    { "n", "<leader>sm" },
    { "n", "<leader>sP" },
    { "n", "<leader>ud" },
    { "n", "<leader>uw" },
    { "n", "<leader>us" },
    { "n", "<leader>ft" },
    { "n", "<leader>fT" },
    { "n", "<leader>uC" },
    { "n", "<leader>uF" },
    { { "n", "t" }, "<C-/>" },
    { { "n", "t" }, "<c-_>" },
    { "n", "<leader><tab>l" },
    { "n", "<leader><tab>f" },
    { "n", "<leader><tab>]" },
    { "n", "<leader><tab>[" },
    { "n", "<leader><tab>d" },
    { "n", "<leader><tab>o" },
    { "n", "<leader><tab><tab>" },
    { "n", "<leader>/" },
    { "n", "<leader>cg" },
    { "n", "<leader>cd" },
    { "n", "<leader>sp" },
    { "n", "<leader>bb" }, -- Không dùng Harpoon/Bufferline, buffer switching qua [b ]b
    { "n", "<leader>sn" }, -- Không cần xem lịch sử thông báo
    { "n", "<leader>uS" }, -- Smooth scroll (Set & Forget)
    { "n", "<leader>up" }, -- Mini pairs (Luôn bật)
    { "n", "<leader>ul" }, -- Line numbers (Dư thừa)
    { "n", "<leader>uL" }, -- Relative Line numbers
    { "n", "<leader>uA" }, -- Tabline vô tác dụng vì đã xóa bufferline
    { "n", "<leader>uh" }, -- Inlay Hints đã bị tắt sâu trong LSP
    { "n", "<leader>ut" }, -- Treesitter Context (Không cần thiết)
    { "n", "<leader>uT" }, -- Treesitter Highlight (Không cần thiết)
    { "n", "<leader>uZ" }, -- Zoom Mode

    -- ========================================
    -- 📚 TỪ ĐIỂN 100% PHÍM TẮT (DÙNG ĐỂ XOÁ)
    -- Bỏ comment (xoá `-- `) ở đầu dòng để Tiêu Diệt phím.
    -- ========================================

    -- ⚙️ Hệ thống & Giao diện
    -- { "n", "<leader>?" }, -- Xem phím tắt của file hiện tại
    -- { "n", "<leader>dps" }, -- Xem hiệu năng (Profiler)
    -- { "n", "<leader>sa" }, -- Danh sách Autocmd
    -- { "n", "<leader>sh" }, -- Tìm trang trợ giúp (Help)
    -- { "n", "<leader>si" }, -- Bảng chọn Icon
    -- { "n", "<leader>sk" }, -- Xem tất cả phím tắt
    -- { "n", "<leader>sM" }, -- Tìm trang Man
    -- { "n", "<leader>uC" }, -- Đổi giao diện (Theme)

    -- 📁 File & Buffer
    -- { "n", "<leader> " }, -- Tìm file (Gốc dự án)
    -- { "n", "<leader>bd" }, -- Đóng Tab hiện tại
    -- { "n", "<leader>cR" }, -- Đổi tên file
    -- { "n", "<leader>fB" }, -- Tất cả Tab
    -- { "n", "<leader>fb" }, -- Danh sách Tab đang mở
    -- { "n", "<leader>fc" }, -- Tìm file cấu hình (Neovim)
    -- { "n", "<leader>fE" }, -- Mở thanh quản lý File (Thư mục hiện tại)
    -- { "n", "<leader>fe" }, -- Mở thanh quản lý File (Gốc dự án)
    -- { "n", "<leader>fF" }, -- Tìm file (Thư mục hiện tại)
    -- { "n", "<leader>ff" }, -- Tìm file (Gốc dự án)
    -- { "n", "<leader>fg" }, -- Tìm file trong Git
    -- { "n", "<leader>fp" }, -- Quản lý dự án (Projects)
    -- { "n", "<leader>fR" }, -- File gần đây (Thư mục hiện tại)
    -- { "n", "<leader>fr" }, -- File gần đây
    -- { "n", "<leader>sb" }, -- Tìm dòng trong file hiện tại
    -- { "n", "[ " }, -- Thêm dòng trống bên trên
    -- { "n", "] " }, -- Thêm dòng trống bên dưới

    -- 📝 Soạn thảo
    -- { { "n", "v" }, "<C-B>" }, -- Cuộn trang lên
    -- { { "n", "v" }, "<C-F>" }, -- Cuộn trang xuống
    -- { { "n", "v", "x" }, "<leader>cF" }, -- Auto Format code nhúng
    -- { { "n", "v", "x" }, "b" }, -- Lùi 1 từ (nhảy qua camelCase)
    -- { { "n", "v", "x" }, "e" }, -- Tới cuối 1 từ (nhảy qua camelCase)
    -- { { "n", "v", "x" }, "gc" }, -- Bật/Tắt Comment (Visual/Normal)
    -- { "n", "gcc" }, -- Bật/Tắt Comment dòng
    -- { { "n", "v", "x" }, "gx" }, -- Mở file/URL dưới con trỏ
    -- { { "n", "v", "x" }, "s" }, -- Nhảy siêu tốc (Flash)
    -- { { "n", "v", "x" }, "w" }, -- Tới 1 từ (nhảy qua camelCase)

    -- 🔍 Tìm kiếm & Grep
    -- { "n", "<leader>s"" }, -- Danh sách Clipboard (Registers)
    -- { "n", "<leader>s/" }, -- Lịch sử tìm kiếm
    -- { "n", "<leader>sB" }, -- Grep trong các file đang mở
    -- { "n", "<leader>sC" }, -- Danh sách lệnh
    -- { "n", "<leader>sc" }, -- Lịch sử lệnh
    -- { "n", "<leader>sG" }, -- Grep thư mục hiện tại
    -- { "n", "<leader>sg" }, -- Grep toàn dự án (Gốc)
    -- { "n", "<leader>sH" }, -- Tìm màu sắc/Highlight
    -- { "n", "<leader>sj" }, -- Lịch sử con trỏ (Jumps)
    -- { "n", "<leader>sl" }, -- Danh sách vị trí (Location List)
    -- { "n", "<leader>sm" }, -- Danh sách đánh dấu (Marks)
    -- { "n", "<leader>sp" }, -- Tìm code cấu hình của Plugin
    -- { "n", "<leader>sq" }, -- Danh sách sửa nhanh (Quickfix)
    -- { "n", "<leader>sR" }, -- Mở lại kết quả tìm kiếm gần nhất
    -- { { "n", "v", "x" }, "<leader>sW" }, -- Tìm từ khóa dưới con trỏ (Thư mục hiện tại)
    -- { { "n", "v", "x" }, "<leader>sw" }, -- Tìm từ khóa dưới con trỏ (Gốc dự án)

    -- 🧠 LSP & Code Navigation
    -- { "n", "[D" }, -- Nhảy đến cảnh báo/lỗi đầu tiên
    -- { "n", "gO" }, -- Danh sách Hàm/Biến trong file
    -- { { "n", "v", "x" }, "gra" }, -- Gợi ý sửa code (Code Action)
    -- { "n", "gri" }, -- Nhảy đến nơi thực thi (Implementation)
    -- { "n", "grn" }, -- Đổi tên biến toàn cục (Rename)
    -- { "n", "grr" }, -- Tìm các nơi sử dụng biến (References)
    -- { "n", "grt" }, -- Nhảy đến định nghĩa kiểu (Type Definition)
    -- { "n", "grx" }, -- Chạy CodeLens

    -- 🌳 Treesitter Text Objects
    -- { { "v", "x" }, "an" }, -- Chọn node cha (Treesitter)
    -- { { "v", "x" }, "in" }, -- Chọn node con (Treesitter)

    -- 🐙 Git & Version Control
    -- { "n", "<leader>gD" }, -- Xem thay đổi Git (So với origin)
    -- { "n", "<leader>gd" }, -- Xem thay đổi Git (Hunk)
    -- { "n", "<leader>gI" }, -- Danh sách GitHub Issues
    -- { "n", "<leader>gi" }, -- GitHub Issues (Đang mở)
    -- { "n", "<leader>go" }, -- Bật/Tắt hiển thị mini.diff
    -- { "n", "<leader>gP" }, -- Danh sách GitHub Pull Requests
    -- { "n", "<leader>gp" }, -- GitHub PRs (Đang mở)
    -- { "n", "<leader>gS" }, -- Danh sách Git Stash
    -- { "n", "<leader>gs" }, -- Git Status

    -- 🔔 Thông báo (Noice)
    -- { "n", "<leader>n" }, -- Lịch sử thông báo
    -- { "n", "<leader>sna" }, -- Tất cả tin nhắn Noice
    -- { "n", "<leader>snd" }, -- Xóa tất cả thông báo
    -- { "n", "<leader>snh" }, -- Lịch sử tin nhắn Noice
    -- { "n", "<leader>snt" }, -- Tìm kiếm tin nhắn Noice
    -- { "n", "<leader>un" }, -- Xóa tất cả thông báo

    -- 🧩 Khác (Mặc định Vim)
    -- { { "v", "x" }, "#" }, -- Tìm từ khóa dưới con trỏ ngược (Visual #)
    -- { "n", "&" }, -- :help &-default
    -- { { "v", "x" }, "*" }, -- Tìm từ khóa dưới con trỏ xuôi (Visual *)
    -- { { "n", "v", "x" }, "<C-Space>" }, -- Treesitter Incremental Selection
    -- { "n", "<C-W> " }, -- Window Hydra Mode (which-key)
    -- { "n", "<C-W><C-D>" }, -- Show diagnostics under the cursor
    -- { "n", "<C-W>d" }, -- Show diagnostics under the cursor
    -- { "n", "<leader>sD" }, -- Buffer Diagnostics
    -- { "n", "<leader>sd" }, -- Diagnostics
    -- { "v", "<S-Tab>" }, -- vim.snippet.jump if active, otherwise <S-Tab>
    -- { "v", "<Tab>" }, -- vim.snippet.jump if active, otherwise <Tab>
    -- { { "v", "x" }, "@" }, -- Chạy Macro (Visual)
    -- { { "v", "x" }, "Q" }, -- Lặp lại Macro (Q)
    -- { "n", "S" }, -- Flash Treesitter
    -- { "n", "Y" }, -- Copy đến cuối dòng (Y)

}

-- Auto-kill tất cả các phím trong sổ đen (Kể cả phím của Plugin)
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
        for _, map in ipairs(keys_to_delete) do
            pcall(vim.keymap.del, map[1], map[2])
        end
    end,
})
-- Dự phòng xoá ngay lập tức cho các phím không thuộc plugin
for _, map in ipairs(keys_to_delete) do
    pcall(vim.keymap.del, map[1], map[2])
end

pcall(vim.keymap.del, "n", "<leader>l")

pcall(vim.keymap.del, "n", "<leader>xx")
pcall(vim.keymap.del, "n", "<leader>xX")

vim.keymap.set("n", "<leader>ua", function()
    local cmd = require("copilot.command")
    if require("copilot.client").is_disabled() then
        cmd.enable()
        vim.notify("Copilot enabled", vim.log.levels.INFO)
    else
        cmd.disable()
        vim.notify("Copilot disabled", vim.log.levels.WARN)
    end
    pcall(function()
        require("lualine").refresh()
    end)
end, { desc = "Toggle AI (Copilot)" })


vim.keymap.set("n", "<leader>sg", function()
    require("snacks").picker.grep()
end, { desc = "Live Grep" })

vim.keymap.set("n", "<leader>uC", function()
    require("snacks").picker.colorschemes()
end, { desc = "Colorscheme" })

pcall(vim.keymap.del, "n", "<leader>gB")
pcall(vim.keymap.del, "n", "<leader>gb")
pcall(vim.keymap.del, "n", "<leader>gd")
pcall(vim.keymap.del, "n", "<leader>gD")

vim.keymap.set("n", "<F2>", function()
    require("snacks").lazygit()
end, { desc = "Lazygit" })

local function set_global_opt(opt_name, state)
    vim.opt[opt_name] = state
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        pcall(vim.api.nvim_win_set_option, win, opt_name, state)
    end
end

local go_st_enabled = true
Snacks.toggle({
    name = "Go ST Warns",
    get = function()
        return go_st_enabled
    end,
    set = function(state)
        go_st_enabled = state
        local clients = vim.lsp.get_clients({ name = "gopls" })
        for _, client in ipairs(clients) do
            client.settings = client.settings or {}
            client.settings.gopls = client.settings.gopls or {}
            client.settings.gopls.analyses = client.settings.gopls.analyses or {}
            client.settings.gopls.analyses.ST1000 = state
            client.settings.gopls.analyses.ST1003 = state
            client.notify("workspace/didChangeConfiguration", { settings = client.settings })
        end
    end,
}):map("<leader>uG")

vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Prev Buffer", silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Prev Buffer (2-hand)", silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next Buffer (2-hand)", silent = true })

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Keymaps" })

vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, desc = "Move Right" })
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, desc = "Move Left" })


vim.keymap.set("n", "<F1>", function()
    require("snacks").explorer()
end, { desc = "Explorer" })


vim.keymap.set("n", "<F11>", function()
    Snacks.picker.undo()
end, { desc = "Undo history" })

vim.keymap.set("n", "<F12>", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Errors" })
