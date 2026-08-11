return {

  -- flash.nvim: BẬT lại - tính năng nhảy vị trí độc quyền của Neovim, VSCode không có
  -- Config chi tiết ở lua/plugins/flash.lua
  { "folke/flash.nvim", enabled = true },

  -- Tắt bảng tìm kiếm & thay thế (grug-far) trong ảnh để học lệnh :%s của Base Vim
  { "MagicDuck/grug-far.nvim", enabled = false },

  -- Tắt hệ thống Debug (DAP) nếu không dùng để làm nhẹ máy và gọn menu <Space>
  { "mfussenegger/nvim-dap", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "theHamsta/nvim-dap-virtual-text", enabled = false },

  -- Tắt tính năng tự động lưu phiên làm việc để luyện tập Đơn Nhiệm tuyệt đối
  { "folke/persistence.nvim", enabled = false },

  -- Tắt thanh Buffer phía trên cùng (Gộp từ file bufferline.lua cũ)
  { "akinsho/bufferline.nvim", enabled = false },

  -- Tắt fzf-lua vì bạn đã có Telescope (tránh việc cài 2 công cụ tìm kiếm trùng lặp chức năng)
  { "ibhagwan/fzf-lua", enabled = false },



  -- Tắt bộ giao diện mặc định tokyonight (vì bạn đã dùng catppuccin)
  { "folke/tokyonight.nvim", enabled = false },

  -- Tắt công cụ đo thời gian khởi động (không cần thiết dùng hàng ngày)
  { "dstein64/vim-startuptime", enabled = false },

  -- Tắt mini.comment vì ts-comments.nvim mới hơn, hiểu Tree-sitter (comment đúng syntax theo ngữ cảnh)
  -- ts-comments.nvim tự detect loại comment theo language trong embedded block (e.g. HTML trong JSX)
  -- NOTE: Dùng nvim-mini/mini.comment thay vì nvim-mini/mini.nvim (không có setup())
  { "nvim-mini/mini.comment", enabled = false },
}

