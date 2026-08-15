return {
  "emmanueltouzery/apidocs.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim",
  },
  cmd = {
    "ApidocsInstall",
    "ApidocsUninstall",
    "ApidocsOpen",
    "ApidocsSearch",
  },
  opts = {
    picker = "snacks", -- Force Snacks picker (Bắt buộc dùng bộ chọn Snacks)
  },
  keys = {
    { "<F2>", "<cmd>ApidocsOpen<cr>", desc = "Search API docs" }, -- Search API docs (Tìm kiếm tài liệu API)
    { "<leader>udi", "<cmd>ApidocsInstall<cr>", desc = "Install API docs" }, -- Install docs (Cài đặt tài liệu)
    { "<leader>udu", "<cmd>ApidocsUninstall<cr>", desc = "Uninstall API docs" }, -- Uninstall docs (Gỡ cài đặt tài liệu)
  },
}
