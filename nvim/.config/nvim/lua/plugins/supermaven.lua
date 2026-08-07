return {
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false, -- QUAN TRỌNG: Load ngay từ đầu để phím tắt <leader>ua hoạt động lập tức
    opts = {
      disable_inline_completion = false,
      disable_keymaps = false,
      keymaps = {
        accept_suggestion = "<Plug>(supermaven-disable-accept)", -- Gán phím ảo để VÔ HIỆU HÓA tính năng Nhận Toàn Bộ
        accept_word = "<C-j>",       -- Ctrl + j: Nhận dần từng chữ
      },
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
    keys = {
      { "<leader>ua", "<cmd>SupermavenToggle<cr>", desc = "Toggle AI (Supermaven)" },
    },
  },
}
