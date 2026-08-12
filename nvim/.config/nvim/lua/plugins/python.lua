return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      anaconda_base_path = "/opt/miniconda3",
      anaconda_envs_path = "~/.conda/envs",
      settings = {
        options = {
          anaconda_base_path = "/opt/miniconda3",
          anaconda_envs_path = "~/.conda/envs",
        },
      },
    },
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

