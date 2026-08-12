
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    optional = true,
    opts = function(_, opts)
      
      opts.select = vim.tbl_deep_extend("force", opts.select or {}, {
        enable = true,
        lookahead = true, -- Tự động nhảy (jump forward) đến object tiếp theo nếu cursor không nằm trong object
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- chọn parameter theo mode visual thường
          ["@function.outer"]  = "V", -- chọn function theo mode linewise visual (chọn cả dòng)
        },
        include_surrounding_whitespace = false,
      })

      opts.move = vim.tbl_deep_extend("force", opts.move or {}, {
        enable = true,
        set_jumps = true, -- Lưu vết nhảy vào jumplist để có thể quay lại bằng Ctrl-O
      })
      
      opts.move.keys = opts.move.keys or {}
      
      opts.move.keys.goto_next_start = vim.tbl_deep_extend("force", opts.move.keys.goto_next_start or {}, {
        ["]m"] = "@function.outer",    -- nhảy đến điểm bắt đầu của function tiếp theo
        ["]d"] = "@conditional.outer", -- nhảy đến điểm bắt đầu của câu lệnh điều kiện (if) tiếp theo
      })
      
      opts.move.keys.goto_previous_start = vim.tbl_deep_extend("force", opts.move.keys.goto_previous_start or {}, {
        ["[m"] = "@function.outer",    -- nhảy về điểm bắt đầu của function trước đó
        ["[d"] = "@conditional.outer", -- nhảy về điểm bắt đầu của câu lệnh điều kiện (if) trước đó
      })

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
