return {
  {
    "folke/noice.nvim",
    opts = {
      -- Trả lại command line (:) về vị trí đáy màn hình truyền thống
      cmdline = {
        view = "cmdline",
      },
      -- Thu gọn các thông báo dài, không dùng popup to ở giữa màn hình
      messages = {
        view = "mini",       -- Hiện thông báo ở góc dưới (nhỏ gọn)
        view_error = "mini", -- Lỗi cũng hiện góc dưới
        view_warn = "mini",  -- Cảnh báo cũng hiện góc dưới
      },
      -- Tắt hệ thống notify của noice để nhường chỗ cho snacks.notifier (đã setup rất đẹp ở bài trước)
      notify = {
        enabled = false,
      },
      -- Đảm bảo không hiện khung popup khi hover (giữ nguyên cách lsp hiển thị mặc định của LazyVim)
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        progress = { enabled = false }, -- Đã có fidget.nvim
      },
      -- Tắt các hiệu ứng popup không cần thiết
      presets = {
        bottom_search = true, -- Thanh search (/) cũng nằm ở đáy
        command_palette = false,
        long_message_to_split = true, 
        lsp_doc_border = false,
      },
    },
  },
}
