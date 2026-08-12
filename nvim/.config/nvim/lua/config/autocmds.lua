-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here


-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- Tắt kiểm tra chính tả (spell check) trên file Markdown — LazyVim bật mặc định, gây rối mắt với tiếng Việt
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Tự động lưu file khi mất tiêu điểm (chuột click ra ngoài app) hoặc khi chuyển file
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("custom_autowrite", { clear = true }),
  callback = function()
    -- Chỉ lưu nếu file có sự thay đổi, là file text bình thường và có quyền ghi
    if vim.bo.modified and vim.bo.buftype == "" and vim.bo.modifiable then
      vim.cmd("silent! w")
    end
  end,
})

-- ÉP TẮT INLAY HINTS (Chữ xám ở cuối dòng): 
-- Một số plugin tự ý bật lên khi attach LSP, dòng này chặn đứng việc đó.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("disable_inlay_hints_forever", { clear = true }),
  callback = function(args)
    -- Tắt ngay lập tức khi một LSP (VD: gopls) vừa cắm vào buffer
    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
  end,
})

-- SỬA LỖI THỤT LỀ JSX TRONG FILE .JS
-- Neovim mặc định coi .js là JS thuần (không có JSX). Nếu code React trong file .js, 
-- Treesitter sẽ bị "mù" và từ chối thụt lề khi ấn Enter ở return().
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.js",
  command = "set filetype=javascriptreact",
})
