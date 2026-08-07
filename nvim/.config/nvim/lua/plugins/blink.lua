return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      -- B2: Bật gợi ý khi gõ lệnh Command Line (dấu hai chấm)
      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
      },
      keymap = {
        preset = "default",
        -- Một mũi tên trúng 3 đích cho phím Enter:
        -- 1. Nếu menu mở -> Chốt (Accept)
        -- 2. Nếu trong khối Snippet -> Nhảy sang ô tiếp theo (Snippet Forward)
        -- 3. Bình thường -> Xuống dòng (Fallback)
        ["<CR>"] = { "accept", "snippet_forward", "fallback" },
        -- Ưu tiên 1: Nếu đang trong Form (Snippet), Tab sẽ nhảy sang ô tiếp theo.
        -- Ưu tiên 2: Nếu đang mở Menu, Tab sẽ đi xuống.
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          supermaven = { enabled = false }, -- Tắt vĩnh viễn Supermaven trong Menu Blink
        },
      },
      completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          draw = {
            -- B1: Thêm Icon trực quan cho các thành phần (Snippets sẽ có icon riệng)
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
          },
        },
        documentation = {
          window = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
        },
      },
      signature = {
        window = { border = "rounded" },
      },
    },
  },
}
