-- Cấu hình plugin Telescope Undo (Tích hợp lịch sử thay đổi file vào Telescope)
-- Tài liệu: Mappings được bọc trong function() để an toàn lazy-loading.

return {
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = function()
      return {
        extensions = {
          undo = {
            -- Hiển thị bản xem trước side-by-side
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
            -- Định dạng thời gian (sử dụng "" để dùng style timeago như "2 hours ago")
            time_format = "", 
            
            -- Cấu hình phím tắt trong popup của undo
            mappings = {
              -- Chế độ Insert
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions, -- Copy các phần thêm mới
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions, -- Copy các phần bị xóa
                ["<C-cr>"] = require("telescope-undo.actions").restore,       -- Khôi phục file về trạng thái này
              },
              -- Chế độ Normal
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
      -- Khởi tạo telescope với opts được truyền vào, đảm bảo extension nhận được configs
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo History" },
      { "<leader>U", "<cmd>Telescope undo<cr>", desc = "Undo History (nhanh)" },
    },
  },
}
