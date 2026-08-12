return {
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      messages = {
        view = "mini",       -- Hiện thông báo ở góc dưới (nhỏ gọn)
        view_error = "mini", -- Lỗi cũng hiện góc dưới
        view_warn = "mini",  -- Cảnh báo cũng hiện góc dưới
      },
      notify = {
        enabled = false,
      },
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        progress = { enabled = false }, -- Đã có fidget.nvim
      },
      presets = {
        bottom_search = true, -- Thanh search (/) cũng nằm ở đáy
        command_palette = false,
        long_message_to_split = true, 
        lsp_doc_border = false,
      },
    },
  },
}
