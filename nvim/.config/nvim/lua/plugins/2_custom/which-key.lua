return {
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      delay = 500,
      win = {
        border = "rounded",  -- Viền bo tròn đẹp mắt
        padding = { 1, 2 },
        wo = {
          winblend = 0,      -- Nền đặc 100%, chặn hoàn toàn code lộn xộn phía sau
        },
      },
      layout = {
        spacing = 4,         -- Giãn cách cột vừa phải
      },
      -- Lưu ý: Mảng `spec` chứa phím Copilot của bạn trước đây 
      -- đã được dời sang "Trạm Ghi Đè" trong file keymaps.lua để quản lý tập trung.
    },
  },
}
