return {
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      delay = 500,
      win = {
        border = "rounded",  -- Viền bo tròn đẹp mắt
        padding = { 1, 2 },
        wo = {
          winblend = 0,      -- Nền đặc 100%, chặn hoàn toàn code lộn xộn phía sau
        },
      },
      layout = {
        spacing = 4,         -- Giãn cách cột vừa phải
      },
      spec = {
        {
          "<leader>ua",
          function()
            local cmd = require("copilot.command")
            if require("copilot.client").is_disabled() then
              cmd.enable()
              vim.notify("Copilot enabled", vim.log.levels.INFO)
            else
              cmd.disable()
              vim.notify("Copilot disabled", vim.log.levels.WARN)
            end
            pcall(function()
              require("lualine").refresh()
            end)
          end,
          desc = "Toggle AI (Copilot)",
          icon = "󰚩",
        },
      },
    },
  },
}
