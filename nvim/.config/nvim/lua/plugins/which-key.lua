return {
  {
    "folke/which-key.nvim",
    opts = {
      -- Tối ưu cho CẢ ít và nhiều thành phần: Dùng 'modern' (Tự động co giãn)
      -- - Ít phím: Sẽ tự thu nhỏ thành 1 bảng bé xinh ở giữa.
      -- - Nhiều phím: Sẽ tự động phình to ra nhiều cột.
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
      spec = {
        -- Khai báo trực tiếp vào Which-Key để ép nó luôn luôn hiển thị
        { "<leader>ua", "<cmd>SupermavenToggle<cr>", desc = "Toggle AI (Supermaven)", icon = "󰚩 " },
      },
    },
  },
}
