-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Tắt chữ báo lỗi nổi gạch chân (virtual text), chỉ giữ lại cảnh báo ở lề trái
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
})

-- Toggle Hardtime (Đã xóa vì plugin đã bị gỡ)
-- Biến phím U (hoa) thành phím Redo (Thay cho Ctrl+r)
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Thoát Terminal mode siêu tốc bằng cách bấm 2 lần Esc
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape Terminal" })

-- Phím F1 hiện đã được bàn giao cho DevDocs (Telescope)
-- Đã xóa lệnh block phím F1 thành ESC.



-- Better movement in visual mode (Drag lines up/down)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Keep cursor centered during search navigation and vertical jumps
vim.keymap.set("n", "n", "nzzzv", { desc = "Search Next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search Prev" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })

-- VSCode-like Undo Breakpoints (Ngắt dòng thời gian Undo)
-- Lưu lại lịch sử mỗi khi bấm Dấu Cách
vim.keymap.set("i", "<Space>", "<Space><c-g>u", { desc = "Undo breakpoint on Space" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

-- Resize window using <C-Arrow>
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Inc Height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Dec Height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Dec Width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Inc Width" })

-- Better visual mode indent (keeps selection)
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- Xóa bỏ hoàn toàn các phím tắt không cần thiết của LazyVim
local keys_to_delete = {
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
    { "n", "<leader>si" },
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
    -- Dọn dẹp phím trùng lặp và ít dùng
    { "n", "<leader>bb" }, -- Dư thừa vì đã dùng Harpoon
    { "n", "<leader>sn" }, -- Không cần xem lịch sử thông báo
    -- Xóa các Menu Toggle rác/vô tác dụng
    { "n", "<leader>uS" }, -- Smooth scroll (Set & Forget)
    { "n", "<leader>up" }, -- Mini pairs (Luôn bật)
    { "n", "<leader>ul" }, -- Line numbers (Dư thừa)
    { "n", "<leader>uL" }, -- Relative Line numbers
    { "n", "<leader>uA" }, -- Tabline vô tác dụng vì đã xóa bufferline
    { "n", "<leader>uh" }, -- Inlay Hints đã bị tắt sâu trong LSP
    { "n", "<leader>ut" }, -- Treesitter Context (Không cần thiết)
    { "n", "<leader>uT" }, -- Treesitter Highlight (Không cần thiết)
    { "n", "<leader>uZ" }, -- Zoom Mode
}

for _, map in ipairs(keys_to_delete) do
    pcall(vim.keymap.del, map[1], map[2])
end

-- Nhường hoàn toàn phím l cho Live Server, xóa lệnh gốc của LazyVim
pcall(vim.keymap.del, "n", "<leader>l")

-- Dời bảng lỗi Trouble sang menu Code (cx và cX) và xóa sổ menu x
pcall(vim.keymap.del, "n", "<leader>xx")
pcall(vim.keymap.del, "n", "<leader>xX")
vim.keymap.set("n", "<leader>cx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Errors" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "Usages" })

-- Chuyển chức năng tìm Todo/Fix/Fixme sang phím thường (st) thay vì (sT)
vim.keymap.set("n", "<leader>st", function()
    require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "Todos" })

-- Khôi phục tính năng Live Grep tìm kiếm toàn dự án
vim.keymap.set("n", "<leader>sg", function()
    require("snacks").picker.grep()
end, { desc = "Live Grep" })

-- Đổi Colorscheme từ C sang c (Sửa lại thành C để không đè lên phím Conceal Level cực kỳ hữu ích của Markdown)
vim.keymap.set("n", "<leader>uC", function()
    require("snacks").picker.colorschemes()
end, { desc = "Colorscheme" })

-- Xóa phím tắt Git cũ của LazyVim để dọn menu
pcall(vim.keymap.del, "n", "<leader>gB")
pcall(vim.keymap.del, "n", "<leader>gb")

-- Lazygit: chỉ dùng F3
vim.keymap.set("n", "<F3>", function()
    require("snacks").lazygit()
end, { desc = "Lazygit" })

-- =========================================================================
-- GLOBAL TOGGLES (Giữ nguyên thiết lập khi chuyển file)
-- =========================================================================

local function set_global_opt(opt_name, state)
    vim.opt[opt_name] = state
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        pcall(vim.api.nvim_win_set_option, win, opt_name, state)
    end
end

-- Đã xóa Wrap và Spell toggles



-- =========================================================================
-- CUSTOM TOGGLES
-- =========================================================================

-- Toggle Golang ST1000/ST1003 Warnings
local go_st_enabled = true
Snacks.toggle({
    name = "Go ST Warns",
    get = function() return go_st_enabled end,
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

-- =========================================================================

-- =========================================================================
-- BUFFER NAVIGATION
-- =========================================================================
vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Prev Buffer", silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>",     { desc = "Next Buffer",     silent = true })

-- =========================================================================
-- WHICH-KEY: xem toàn bộ keymaps
-- =========================================================================
vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Keymaps" })

-- =========================================================================
-- INSERT MODE NAVIGATION
-- =========================================================================
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, desc = 'Move Right' })
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, desc = 'Move Left' })

-- =========================================================================
-- SUPERMAVEN AI (Đã được chuyển sang which-key.lua để đảm bảo hiển thị)
-- =========================================================================

-- =========================================================================
-- CHÈN NHANH TODO / FIXME THÔNG MINH (TỰ NHẬN DIỆN NGÔN NGỮ)
-- =========================================================================
vim.keymap.set("n", "<F12>", "oTODO: <Esc>gccA", { desc = "Insert TODO", remap = true })
vim.keymap.set("n", "<F11>", "oFIXME: <Esc>gccA", { desc = "Insert FIXME", remap = true })


-- =========================================================================
-- EXPLORER (SNACKS)
-- =========================================================================
vim.keymap.set("n", "<F1>", function() require("snacks").explorer() end, { desc = "Explorer" })
