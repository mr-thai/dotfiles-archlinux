return {
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter" }, -- Đảm bảo plugin được chạy khi gõ code
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "svelte",
            "pug",
            "typescriptreact",
            "vue",
            "php",
          },
        },
      },
    },
  },
}
