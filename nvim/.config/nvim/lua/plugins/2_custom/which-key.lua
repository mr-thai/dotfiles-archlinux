return {
  {
    "folke/which-key.nvim",
    opts = {

      win = {
        border = "rounded", -- Viền bo tròn đẹp mắt
        padding = { 1, 2 },
        col = math.huge,
        row = math.huge,
        wo = {
          winblend = 15,
        },
      },
      layout = {
        spacing = 1, -- Giãn cách cột vừa phải
      },
      -- Lưu ý: Mảng `spec` chứa phím Copilot của bạn trước đây
      -- đã được dời sang "Trạm Ghi Đè" trong file keymaps.lua để quản lý tập trung.
    },
  },
}
