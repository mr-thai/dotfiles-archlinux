return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "prettier", -- Formatter tiêu chuẩn thế giới cho Frontend
        "eslint_d", -- Linter siêu nhanh cho JS/TS

        "black",    -- Formatter phổ biến nhất của Python
        "isort",    -- Tự động sắp xếp các dòng import cho Python
        "flake8",   -- Linter bắt lỗi Python

        "stylua",   -- Formatter chuẩn cho Lua

        "marksman", -- Markdown LSP hỗ trợ viết docs
      })
    end,
  },
}
