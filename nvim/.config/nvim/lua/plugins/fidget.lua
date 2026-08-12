
return {
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,       -- Trong suốt hoàn toàn (không có background)
          border = "none",
          align = "bottom",
        },
      },
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
