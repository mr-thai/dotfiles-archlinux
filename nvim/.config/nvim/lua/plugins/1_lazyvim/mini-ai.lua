return {
  {
    "nvim-mini/mini.ai",
    opts = function(_, opts)
      local ai = require("mini.ai")
      
      opts.n_lines = 100
      
      opts.custom_textobjects = opts.custom_textobjects or {}
      
      opts.custom_textobjects.f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
      
      opts.custom_textobjects.c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
      
      opts.custom_textobjects.a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" })
      
      return opts
    end,
  },
}
