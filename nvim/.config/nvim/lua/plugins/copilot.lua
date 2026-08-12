return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter", -- Khởi động tự động khi bạn bắt đầu gõ code
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false }, -- Bắt buộc tắt để nhường cho blink
      panel = { enabled = false },
      filetypes = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        lua = true,
        python = true,
        markdown = true,
        help = true,
      },
    },
  },
}
