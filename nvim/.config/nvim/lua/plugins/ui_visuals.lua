return {
  { "sphamba/smear-cursor.nvim", enabled = false },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      render = "background", 
      enable_tailwind = true, 
      enable_named_colors = true,
    },
  },
  }
