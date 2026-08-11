-- Cấu hình treesitter textobjects
-- Plugin: nvim-treesitter/nvim-treesitter-textobjects (đã cài sẵn bởi LazyVim)
-- Cho phép thao tác nâng cao bằng cách dùng Treesitter như chọn, nhảy, đổi chỗ (swap) dựa trên cú pháp.

return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- Optional = true để chỉ override/extend khi LazyVim load plugin này, không tự động cài nếu không có.
    optional = true,
    opts = function(_, opts)
      
      -- 1. Cấu hình tính năng 'select' (chọn text object)
      opts.select = vim.tbl_deep_extend("force", opts.select or {}, {
        enable = true,
        lookahead = true, -- Tự động nhảy (jump forward) đến object tiếp theo nếu cursor không nằm trong object
        keymaps = {
          -- Chọn function (af/if)
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          
          -- Chọn class (ac/ic)
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          
          -- Chọn argument/parameter (aa/ia)
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- chọn parameter theo mode visual thường
          ["@function.outer"]  = "V", -- chọn function theo mode linewise visual (chọn cả dòng)
        },
        include_surrounding_whitespace = false,
      })

      -- 2. Cấu hình tính năng 'move' (nhảy)
      opts.move = vim.tbl_deep_extend("force", opts.move or {}, {
        enable = true,
        set_jumps = true, -- Lưu vết nhảy vào jumplist để có thể quay lại bằng Ctrl-O
      })
      
      -- LazyVim sử dụng cấu trúc keys trong `move` để bind phím một cách gọn gàng
      opts.move.keys = opts.move.keys or {}
      
      opts.move.keys.goto_next_start = vim.tbl_deep_extend("force", opts.move.keys.goto_next_start or {}, {
        ["]m"] = "@function.outer",    -- nhảy đến điểm bắt đầu của function tiếp theo
        ["]d"] = "@conditional.outer", -- nhảy đến điểm bắt đầu của câu lệnh điều kiện (if) tiếp theo
      })
      
      opts.move.keys.goto_previous_start = vim.tbl_deep_extend("force", opts.move.keys.goto_previous_start or {}, {
        ["[m"] = "@function.outer",    -- nhảy về điểm bắt đầu của function trước đó
        ["[d"] = "@conditional.outer", -- nhảy về điểm bắt đầu của câu lệnh điều kiện (if) trước đó
      })

      -- 3. Cấu hình tính năng 'swap' (đổi chỗ)
      opts.swap = vim.tbl_deep_extend("force", opts.swap or {}, {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner", -- Swap parameter với parameter tiếp theo (bên phải)
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner", -- Swap parameter với parameter trước đó (bên trái)
        },
      })
      
      return opts
    end,
  },
}
