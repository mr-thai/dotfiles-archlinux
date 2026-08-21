return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- LazyVim 'ai.copilot' đã tự động lo phần sources rồi,
      -- ta chỉ việc cấu hình giao diện bo tròn (Rounded UI)
      opts.completion = opts.completion or {}
      opts.completion.menu = opts.completion.menu or {}
      opts.completion.menu.border = "rounded"

      opts.signature = opts.signature or {}
      opts.signature.window = opts.signature.window or {}
      opts.signature.window.border = "rounded"

      opts.completion.documentation = opts.completion.documentation or {}
      opts.completion.documentation.window = {
        border = "rounded",
        max_width = 90,
        max_height = 25,
      }

      return opts
    end,
  },
}
