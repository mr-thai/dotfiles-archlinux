return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}

      -- Chỉ giữ lại hiển thị tiến trình (progress) ở lualine_y,
      -- nhường toàn bộ việc hiển thị Copilot cho hệ thống mặc định của LazyVim!
      opts.sections.lualine_y = {
        { "progress", padding = { left = 1, right = 1 } },
      }

      opts.sections.lualine_z = { "location" }
    end,
  },
}
