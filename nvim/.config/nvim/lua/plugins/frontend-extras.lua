return {
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = true,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "BufRead package.json",
    opts = {
      autostart = true,
      hide_up_to_date = false,
      hide_unmatched = false,
    },
  }
}
