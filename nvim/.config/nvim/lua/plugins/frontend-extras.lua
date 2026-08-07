return {
  -- Dịch lỗi TypeScript sang tiếng Anh dễ hiểu
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = true,
  },
  -- Hiển thị version của các package npm ngay trong package.json
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
