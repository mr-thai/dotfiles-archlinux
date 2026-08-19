return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, {
        { "<leader>G", hidden = true },
        { "<leader>d", hidden = true },
        { "<leader>L", hidden = true },
        { "<leader>S", hidden = true },
        { "<leader>.", hidden = true },
        { "<leader><tab>", hidden = true },
        { "<leader>qq", hidden = true },
        { "<leader>ft", hidden = true },
        { "<leader>fT", hidden = true },
        { "<C-/>", hidden = true },
        { "<c-_>", hidden = true },
        { "<leader>K", hidden = true }, -- Keywordprg
        { "<leader>E", hidden = true }, -- Explorer (cwd) (đã có e là đủ)
        { "<leader>,", hidden = true }, -- Switch Buffer (đã có [b ]b)
        { "<leader>`", hidden = true }, -- Switch Other Buffer
        { "<leader>:", hidden = true }, -- Command History
        { "<leader>?", hidden = true }, -- Buffer Keymaps
        { "<leader>n", hidden = true }, -- Notification History
        { "<leader>w", hidden = true }, -- Windows menu
        
        { "<leader>bD", hidden = true },
        { "<leader>bi", hidden = true },
        
        { "<leader>cF", hidden = true },
        { "<leader>cf", hidden = true },
        { "<leader>ch", hidden = true },

        { "<leader>gB", hidden = true },
        { "<leader>gc", hidden = true },
        { "<leader>gd", hidden = true },
        { "<leader>gf", hidden = true },
        { "<leader>gG", hidden = true },
        { "<leader>gl", hidden = true },
        { "<leader>gL", hidden = true },
        { "<leader>go", hidden = true },
        { "<leader>gs", hidden = true },
        { "<leader>gS", hidden = true },
        { "<leader>gY", hidden = true },

        { "<leader>f", hidden = true },

        { "<leader>x", hidden = true },

        { "<leader>sn", hidden = true },
        { "<leader>sa", hidden = true },
        { "<leader>sb", hidden = true },
        { "<leader>sB", hidden = true },
        { "<leader>sc", hidden = true },
        { "<leader>sC", hidden = true },
        { "<leader>sD", hidden = true },
        { "<leader>sd", hidden = true },
        { "<leader>sG", hidden = true },
        { "<leader>sh", hidden = true },
        { "<leader>sH", hidden = true },
        { "<leader>si", hidden = true },
        { "<leader>sj", hidden = true },
        { "<leader>sm", hidden = true },
        { "<leader>sP", hidden = true },
        { "<leader>sk", hidden = true },
        { "<leader>sl", hidden = true },
        { "<leader>sM", hidden = true },
        { "<leader>so", hidden = true },
        { "<leader>sq", hidden = true },
        { "<leader>sR", hidden = true },
        { "<leader>sT", hidden = true },
        { "<leader>sW", hidden = true },
        { "<leader>s\"", hidden = true },
        { "<leader>s/", hidden = true },

        { "<leader>uA", hidden = true },
        { "<leader>uD", hidden = true },
        { "<leader>ud", hidden = true },
        { "<leader>ug", hidden = true },
        { "<leader>uG", hidden = true },
        { "<leader>ui", hidden = true },
        { "<leader>uI", hidden = true },
        { "<leader>ul", hidden = true },
        { "<leader>uL", hidden = true },
        { "<leader>un", hidden = true },
        { "<leader>up", hidden = true },
        { "<leader>ur", hidden = true },
        { "<leader>uS", hidden = true },
        { "<leader>uT", hidden = true },
        { "<leader>uH", hidden = true },
        { "<leader>us", hidden = true },
        { "<leader>uw", hidden = true },
        { "<leader>uz", hidden = true },
        { "<leader>uZ", hidden = true },

        { "<leader>e", hidden = true },
        { "<leader><space>", desc = "Files" },
        { "<leader>/", hidden = true },
        { "<leader>sw", desc = "Word" },

        { "<leader>u", group = "+System / Update", icon = "" },

        { "<leader>cm", hidden = true },
        { "<leader>cR", hidden = true },
        { "<leader>cS", hidden = true },
        { "<leader>cf", hidden = true },
        { "<leader>ch", hidden = true },
        { "<leader>g", hidden = true },
        { "<leader>on", hidden = true },
        { "<leader>os", hidden = true },
        { "<leader>cg", hidden = true },
        { "<leader>cd", hidden = true },
        { "<leader>sp", hidden = true },
        
        { "<leader>ss", desc = "Symbol" },
        { "<leader>sS", desc = "Global Symbol" },
        { "<leader>fc", desc = "Config Files" },
        { "<leader>uC", hidden = true },
        { "<leader>uF", hidden = true },

        { "<F3>", desc = "Lazygit", icon = "󰊢" },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>S", false }, -- Ngăn chặn tạo Scratch Buffers
      { "<leader>.", false }, -- Ngăn chặn tạo Scratch Buffers
      { "<leader>/", false }, -- Tắt phím Grep mặc định
    }
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>/", false }, -- Tắt phím Grep mặc định
    },
  }
}
