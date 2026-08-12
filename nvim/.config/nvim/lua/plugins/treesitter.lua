return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.indent = { enable = true } -- Bắt buộc bật tính năng thụt lề của Treesitter
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
        })
      end
    end,
  },
}
