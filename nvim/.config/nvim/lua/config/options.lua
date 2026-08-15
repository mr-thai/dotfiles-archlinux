
vim.opt.mouse = "a" -- Enable mouse in all modes

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for easier movement

vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4         -- Number of spaces tabs count for
vim.opt.smartindent = true
vim.opt.autoindent = true   -- Copy indent from current line when starting a new one

vim.opt.ignorecase = true  -- Case-insensitive search
vim.opt.smartcase = true   -- Case-sensitive if there's capital letters
vim.opt.hlsearch = true     -- Highlight search results

vim.opt.cursorline = true      -- Highlight the current line
vim.opt.wrap = false           -- Disable line wrapping by default
vim.opt.scrolloff = 8          -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8      -- Minimal number of screen columns to keep to the left and right
vim.opt.signcolumn = "yes"     -- Always show the signcolumn to avoid shifting text
vim.opt.termguicolors = true   -- Enable true color support
vim.opt.splitright = true      -- Vertical split to the right
vim.opt.splitbelow = true      -- Horizontal split to the bottom
vim.opt.smoothscroll = true    -- Smooth scrolling
vim.opt.showtabline = 0        -- Hide native tabline completely

vim.opt.updatetime = 250       -- Faster completion and diagnostic updates
vim.opt.timeoutlen = 300       -- Keymap timeout length
vim.opt.undofile = true        -- Persistent undo history
vim.opt.backup = false         -- Do not create backup files
vim.opt.writebackup = false    -- Do not write backup files
vim.opt.swapfile = false       -- Do not use swap files

vim.g.root_spec = { ".git", "lua", "cwd" }

-- Auto-detect Python 3 Host safely (Tự động nhận diện Python 3 Host an toàn)
local python_path = vim.fn.exepath("python3")
if python_path == "" then
    python_path = vim.fn.exepath("python")
end

if python_path ~= "" then
    vim.g.python3_host_prog = python_path
end
