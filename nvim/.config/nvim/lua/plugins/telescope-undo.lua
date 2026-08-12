
return {
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = function()
      return {
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
            time_format = "", 
            
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions, -- Copy các phần thêm mới
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions, -- Copy các phần bị xóa
                ["<C-cr>"] = require("telescope-undo.actions").restore,       -- Khôi phục file về trạng thái này
              },
              n = {
                ["y"] = require("telescope-undo.actions").yank_additions, -- Nhấn y: copy additions
                ["Y"] = require("telescope-undo.actions").yank_deletions, -- Nhấn Y: copy deletions
                ["u"] = require("telescope-undo.actions").restore,        -- Nhấn u: khôi phục file
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo History" },
      { "<leader>U", "<cmd>Telescope undo<cr>", desc = "Undo History (nhanh)" },
    },
  },
}
