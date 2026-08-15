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
            -- Get running Copilot clients (Lấy danh sách client Copilot đang chạy)
            local clients = vim.lsp.get_clients({ name = "copilot" })
            if #clients > 0 then
              -- Disable Copilot completely (Tắt hoàn toàn Copilot)
              vim.cmd("Copilot disable")
              vim.notify("Copilot disabled", vim.log.levels.WARN)
            else
              -- Enable Copilot (Bật lại Copilot)
              vim.cmd("Copilot enable")
              vim.notify("Copilot enabled", vim.log.levels.INFO)
            end
          end, 
          desc = "Toggle AI (Copilot)", 
          icon = " " -- Toggle switch icon (Icon dạng gạt)
        },
      },
    },
  },
}
