
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",

    opts = {

      labels = "asdfghjklqwertyuiop",

      search = {
        multi_window = true,
        mode = "exact",
      },

      jump = {
        jumplist = true,
        autojump = false,
        nohlsearch = true,
      },

      label = {
        after = true,
        before = false,
        distance = true,
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },

      highlight = {
        backdrop = true,
      },

      modes = {
        char = {
          enabled = true,
          jump_labels = true,
          multi_line = true,
          label = { exclude = "hjkliardc" },
        },

        search = {
          enabled = false,
        },

        treesitter = {
          label = {
            before = true,
            after = true,
            style = "inline", -- README: style = "inline"
          },
        },
      },

      prompt = {
        enabled = true,
        prefix = { { "⚡ Flash: ", "FlashPromptIcon" } },
      },
    },

    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,             desc = "Flash Remote" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },
      { "<c-s>", mode = { "c" },       function() require("flash").toggle() end,             desc = "Toggle Flash Search" },
    },
  },

  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-s>"] = { "flash", mode = { "n", "i" } },
              ["s"] = { "flash" },
            },
          },
        },
        actions = {
          flash = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
        },
      },
    },
  },
}
