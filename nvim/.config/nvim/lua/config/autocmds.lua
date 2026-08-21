
require("config.mode_highlight")


vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("custom_autowrite", { clear = true }),
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.bo.modifiable then
      vim.cmd("silent! w")
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("disable_inlay_hints_forever", { clear = true }),
  callback = function(args)
    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.js",
  command = "set filetype=javascriptreact",
})

-- ==========================================
-- DANH SÁCH CÁC AUGROUP MẶC ĐỊNH CỦA LAZYVIM
-- (Bỏ comment lệnh vim.api.nvim_del_augroup_by_name để vô hiệu hoá augroup tương ứng)
-- ==========================================

-- 1. Tự động kiểm tra và reload file nếu bị thay đổi từ bên ngoài (FocusGained, TermClose, TermLeave)
-- vim.api.nvim_del_augroup_by_name("lazyvim_checktime")

-- 2. Nháy sáng (highlight) vùng văn bản vừa copy/yank trong chốc lát (TextYankPost)
-- vim.api.nvim_del_augroup_by_name("lazyvim_highlight_yank")

-- 3. Tự động cân bằng lại kích thước các cửa sổ split (wincmd =) khi resize terminal (VimResized)
-- vim.api.nvim_del_augroup_by_name("lazyvim_resize_splits")

-- 4. Tự động nhảy con trỏ về vị trí dòng sửa cuối cùng khi mở lại file (BufReadPost)
-- vim.api.nvim_del_augroup_by_name("lazyvim_last_loc")

-- 5. Đóng nhanh các cửa sổ đặc biệt (help, qf, lspinfo, notify, grug-far...) bằng phím 'q' (FileType)
-- vim.api.nvim_del_augroup_by_name("lazyvim_close_with_q")

-- 6. Đặt buffer đọc tài liệu man page thành buflisted = false để không làm rác danh sách buffer (FileType man)
-- vim.api.nvim_del_augroup_by_name("lazyvim_man_unlisted")

-- 7. Tự động bật ngắt dòng (wrap) và kiểm tra chính tả (spell) cho file văn bản (FileType text, markdown...)
-- vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell") -- (Lưu ý: Đã được vô hiệu hóa chủ động ở dòng 5 phía trên)

-- 8. Đặt conceallevel = 0 cho file JSON để luôn hiện đầy đủ dấu ngoặc kép (FileType json, jsonc, json5)
-- vim.api.nvim_del_augroup_by_name("lazyvim_json_conceal")

-- 9. Tự động tạo thư mục cha (mkdir -p) khi lưu file nếu thư mục chưa tồn tại (BufWritePre)
-- vim.api.nvim_del_augroup_by_name("lazyvim_auto_create_dir")

-- --- Các Augroup Nâng Cao / Core Khác Trong LazyVim (Tùy chọn can thiệp) ---
-- vim.api.nvim_del_augroup_by_name("lazyvim_root_cache")            -- Tắt cache tự động root directory của LazyVim
-- vim.api.nvim_del_augroup_by_name("LazyFormat")                   -- Tắt autocommand tự động format on save của LazyVim
-- vim.api.nvim_del_augroup_by_name("lazyvim_treesitter")            -- Tắt autocommand tự động kích hoạt Treesitter cho filetype
-- vim.api.nvim_del_augroup_by_name("lazyvim_treesitter_textobjects")-- Tắt autocommand gắn phím tắt di chuyển textobjects Treesitter
-- vim.api.nvim_del_augroup_by_name("nvim-lint")                    -- Tắt autocommand tự động chạy linter của nvim-lint

