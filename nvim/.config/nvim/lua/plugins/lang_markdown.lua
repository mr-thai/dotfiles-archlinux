return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      enabled = true,
      anti_conceal = { enabled = true },
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      code = {
        enabled = true,
        sign = true,
        style = "full",
        border = "thin",
      },
      dash = { enabled = true },
      bullet = { enabled = true },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked   = { icon = "󰱒 " },
      },
      table = { enabled = true },
      latex = { enabled = false },
    },
  }
}
