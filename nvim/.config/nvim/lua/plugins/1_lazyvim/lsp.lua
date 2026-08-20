return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- Tắt vĩnh viễn Inlay hints ở tầng gốc (LSP)
      diagnostics = {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
      },

      -- ==========================================
      -- BOILERPLATE CẤU HÌNH & GHI ĐÈ LSP SERVERS
      -- (Bỏ comment để bật/tắt hoặc tuỳ biến cấu hình từng LSP server)
      -- ==========================================
      -- codelens = { enabled = false }, -- Bật/tắt hiển thị tham chiếu/test trực tiếp trên dòng mã
      -- folds = { enabled = true },     -- Bật/tắt tính năng gấp code bằng LSP
      -- servers = {
      --   -- Lua Language Server (lua_ls)
      --   lua_ls = {
      --     -- mason = false, -- Đặt false nếu muốn dùng binary cài ngoài hệ thống thay vì Mason
      --     -- enabled = false, -- Đặt false nếu muốn vô hiệu hoá hoàn toàn
      --     settings = {
      --       Lua = {
      --         workspace = { checkThirdParty = false },
      --         completion = { callSnippet = "Replace" },
      --         hint = { enable = false },
      --       },
      --     },
      --   },
      --   -- Python LSP (pyright / basedpyright)
      --   -- pyright = {
      --   --   enabled = true,
      --   --   settings = {
      --   --     python = {
      --   --       analysis = {
      --   --         typeCheckingMode = "basic",
      --   --         autoSearchPaths = true,
      --   --         useLibraryCodeForTypes = true,
      --   --       },
      --   --     },
      --   --   },
      --   -- },
      --   -- Go LSP (gopls)
      --   -- gopls = {
      --   --   enabled = true,
      --   --   settings = {
      --   --     gopls = {
      --   --       analyses = { unusedparams = true },
      --   --       hints = { assignVariableTypes = true, compositeLiteralFields = true },
      --   --     },
      --   --   },
      --   -- },
      --   -- TypeScript / JavaScript LSP (vtsls)
      --   -- vtsls = { enabled = true },
      --   -- Ví dụ vô hiệu hoá bất kỳ LSP server nào:
      --   -- example_server = { enabled = false },
      -- },
    },
  },
}
