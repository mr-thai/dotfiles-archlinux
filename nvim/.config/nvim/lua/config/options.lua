-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Mouse support
vim.opt.mouse = "a" -- Enable mouse in all modes

-- Clipboard synchronization (System clipboard)
vim.opt.clipboard = "unnamedplus"

-- Line numbering
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for easier movement

-- Indentation and Tabs
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4         -- Number of spaces tabs count for
vim.opt.smartindent = true
vim.opt.autoindent = true   -- Copy indent from current line when starting a new one

-- Search behavior
vim.opt.ignorecase = true  -- Case-insensitive search
vim.opt.smartcase = true   -- Case-sensitive if there's capital letters
vim.opt.hlsearch = true     -- Highlight search results

-- Interface and layout
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

-- Performance and system
vim.opt.updatetime = 250       -- Faster completion and diagnostic updates
vim.opt.timeoutlen = 300       -- Keymap timeout length
vim.opt.undofile = true        -- Persistent undo history
vim.opt.backup = false         -- Do not create backup files
vim.opt.writebackup = false    -- Do not write backup files
vim.opt.swapfile = false       -- Do not use swap files

-- Đặt .git làm thư mục gốc (ưu tiên cao nhất) để không bị LSP ghi đè thư mục làm việc
vim.g.root_spec = { ".git", "lua", "cwd" }

-- Conda Python provider cho Neovim
vim.g.python3_host_prog = vim.fn.expand("~/.conda/envs/neovim/bin/python")
