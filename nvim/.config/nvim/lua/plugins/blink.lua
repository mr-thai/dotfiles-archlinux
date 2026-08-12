return {
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "mikavilpas/blink-ripgrep.nvim",
        version = "*",
      },
      {
        "giuxtaposition/blink-cmp-copilot",
      },
    },
    opts = {
      fuzzy = {
        sorts = { "exact", "score", "sort_text" },
      },
      completion = {
        menu = {
          border = "rounded",
          max_height = 12,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
        trigger = {
          show_on_backspace = false,
        },
        documentation = {
          window = {
            border = "rounded",
            max_width = 90,
            max_height = 25,
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
      },
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
      sources = {
        default = { "copilot", "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 90,
            async = true,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          lsp        = { score_offset = 100 },
          buffer     = { score_offset = -5  },
          ripgrep = {
            module = "blink-ripgrep",
            name   = "Ripgrep",
            score_offset = -8,
            async = true,
            opts = {
              prefix_min_len = 3,
              backend = { use = "gitgrep-or-ripgrep" },
              project_root_marker = { ".git", "package.json" },
            },
          },
        },
      },
      keymap = {
        preset = "default",
        ["<CR>"]    = { "accept", "fallback" },
        ["<Tab>"]   = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
      },
    },
  },
}
