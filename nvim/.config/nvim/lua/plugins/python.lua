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

  -- python-import.nvim: Tự động thêm import Python khi gõ tên module chưa import
  -- Hoạt động local qua Tree-sitter + LSP, không cần API hay server riêng
  -- Dùng: <leader>i để thêm import cho symbol dưới cursor
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

