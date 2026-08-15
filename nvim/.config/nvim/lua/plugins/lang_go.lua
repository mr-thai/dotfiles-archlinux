return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        gofmt = "gofumpt",
        lsp_cfg = false,
        lsp_gofumpt = true,
        lsp_on_attach = false,
        test_runner = "go",
        run_in_floaterm = false,
        dap_debug = false,
        lsp_inlay_hints = { enable = false }, -- Disable inlay hints completely (Tắt hoàn toàn inlay hints)
        icons = { breakpoint = "🔴", currentpos = "▶" },
      })
    end,
    keys = {
      { "<leader>gt",  "<cmd>GoTest<cr>",        ft = "go", desc = "Go: Run tests" },
      { "<leader>gT",  "<cmd>GoTestFile<cr>",    ft = "go", desc = "Go: Test current file" },
      { "<leader>gcv", "<cmd>GoCoverage<cr>",    ft = "go", desc = "Go: Show coverage" },
      { "<leader>gat", "<cmd>GoAddTag<cr>",      ft = "go", desc = "Go: Add struct tags" },
      { "<leader>grt", "<cmd>GoRmTag<cr>",       ft = "go", desc = "Go: Remove struct tags" },
      { "<leader>gfs", "<cmd>GoFillStruct<cr>",  ft = "go", desc = "Go: Fill struct fields" },
      { "<leader>gie", "<cmd>GoIfErr<cr>",       ft = "go", desc = "Go: Add if err != nil" },
      { "<leader>gim", "<cmd>GoImpl<cr>",        ft = "go", desc = "Go: Implement Interface" },
    },
  },
}
