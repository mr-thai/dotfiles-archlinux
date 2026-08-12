
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
