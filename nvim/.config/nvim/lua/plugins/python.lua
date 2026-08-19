return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = {},
  },

  {
    "kiyoon/python-import.nvim",
    build = "pip3 install --user -r requirements.txt",
    ft = { "python" },
    keys = {
      { "<leader>i",  "<cmd>PythonImportThisOrStatement<cr>", mode = { "n" }, ft = "python", desc = "Import: Add for symbol" },
      { "<leader>I",  "<cmd>PythonImportThisOrStatement<cr>", mode = { "v" }, ft = "python", desc = "Import: Add for selection" },
      { "<leader>uI", "<cmd>PythonImportAll<cr>",             mode = { "n" }, ft = "python", desc = "Import: Add all missing" },
    },
  },
}

