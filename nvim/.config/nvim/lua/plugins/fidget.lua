-- fidget.nvim: Hiển thị LSP loading progress ở góc dưới-phải
-- Khi mở file/project, LSP cần thời gian index → fidget hiện spinner nhỏ
-- Tự biến mất khi LSP sẵn sàng. Zero config, không ảnh hưởng workflow.

return {
  {
    "j-hui/fidget.nvim",
    opts = {
      -- Notification window nhỏ gọn ở góc dưới-phải
      notification = {
        window = {
          winblend = 0,       -- Trong suốt hoàn toàn (không có background)
          border = "none",
          align = "bottom",
        },
      },
      -- Spinner animation nhỏ khi LSP đang chạy
      progress = {
        display = {
          render_limit = 3,   -- Hiện tối đa 3 LSP task cùng lúc
          done_ttl = 1,       -- Biến mất sau 1 giây khi xong
          progress_icon = { pattern = "dots", period = 1 },
        },
      },
    },
  },
}
