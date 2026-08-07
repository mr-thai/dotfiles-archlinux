return {
  -- Ép tắt tính năng con trỏ sao chổi (đuôi con trỏ)
  { "sphamba/smear-cursor.nvim", enabled = false },
  -- Hiển thị màu thực tế cho các mã màu Hex/Tailwind
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      render = "background", 
      enable_tailwind = true, 
      enable_named_colors = true,
    },
  },
  -- Làm nổi bật từ giống nhau (Siêu nhẹ, thay thế illuminate)
  {
    "nvim-mini/mini.cursorword",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
  },
  -- Đổi màu background con trỏ theo từng Mode (Insert, Visual...)
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = {
          copy = "#f9e2af",   -- Yellow
          delete = "#f38ba8", -- Red
          insert = "#a6e3a1", -- Green (Insert)
          visual = "#cba6f7", -- Mauve (Visual)
        },
        line_opacity = 0.20, -- Giảm cường độ màu xuống mức 20% cho dịu mắt hơn
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        ignore = { "NvimTree", "TelescopePrompt", "lazy", "snacks_dashboard" },
      })
      -- M1: Khối vuông tĩnh ở Normal, Vạch dọc NHẤP NHÁY LIÊN TỤC ở Insert
      vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"
    end,
  },
}
