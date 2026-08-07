return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  -- Lazy.nvim tự động kích hoạt qua phím tắt (keys), không cần lazy = false
  lazy = true,
  opts = {
    dir_path = vim.fn.stdpath("data") .. "/devdocs", -- Nơi lưu tài liệu offline
    previewer_cmd = nil, -- Dùng trình hiển thị markdown có sẵn của Neovim
    float_win = {
      relative = "editor",
      border = "rounded", -- Viền bo góc cho cửa sổ nổi đẹp mắt
      width = 100,
      height = 30,
    },
    wrap = true, -- Tự động xuống dòng khi text quá dài
  },
  cmd = {
    "DevdocsInstall",
    "DevdocsUninstall",
    "DevdocsOpen",
    "DevdocsOpenFloat",
    "DevdocsToggle",
  },
  keys = {
    -- CÁC PHÍM TẮT SỬ DỤNG HÀNG NGÀY (SIÊU TỐC ĐỘ):
    -- 1. Tìm kiếm toàn cục (Bấm 1 phát ăn ngay)
    { "<F2>", "<cmd>DevdocsOpen<cr>", desc = "Tìm kiếm DevDocs" },
    -- 2. Đọc giải thích từ dưới con trỏ chuột
    { "gh", "<cmd>DevdocsOpenFloat<cr>", desc = "Đọc tài liệu dưới con trỏ" },

    -- CÁC PHÍM TẮT QUẢN LÝ (Giấu vào nhóm ud - DevDocs):
    { "<leader>udi", "<cmd>DevdocsInstall<cr>", desc = "Install" },
    { "<leader>udu", "<cmd>DevdocsUninstall<cr>", desc = "Uninstall" },
  },
}
