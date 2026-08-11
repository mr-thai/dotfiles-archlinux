-- =============================================================================
-- blink.cmp - Cấu hình nâng cấp Senior cho Fresher học code
-- Tài liệu gốc đọc trực tiếp từ:
--   ~/.local/share/nvim/lazy/blink.cmp/lua/blink/cmp/config/
--   https://github.com/mikavilpas/blink-ripgrep.nvim (README gốc)
-- Nguyên tắc: Chỉ dùng `opts` để THÊM lên cấu hình LazyVim mặc định.
--             KHÔNG khai báo lại module/name/snippets.preset để tránh conflict.
--             Ngoại lệ: external providers (ripgrep) BẮT BUỘC phải có module+name
-- =============================================================================

return {
  {
    "saghen/blink.cmp",
    -- Thêm blink-ripgrep làm dependency của blink.cmp
    -- Theo đúng tài liệu gốc: https://github.com/mikavilpas/blink-ripgrep.nvim
    dependencies = {
      {
        "mikavilpas/blink-ripgrep.nvim",
        version = "*", -- dùng bản stable mới nhất
      },
    },
    opts = {

      -- -----------------------------------------------------------------------
      -- FUZZY - Sắp xếp thông minh học theo thói quen (frecency)
      -- Source: config/fuzzy.lua
      -- -----------------------------------------------------------------------
      fuzzy = {
        -- 'exact': gõ đúng chữ thì lên đầu tiên
        -- 'score': sau đó là fuzzy score
        -- 'sort_text': sau cùng theo thứ tự LSP gốc
        -- frecency mặc định BẬT: tự học và đẩy thứ hay dùng lên đầu
        sorts = { "exact", "score", "sort_text" },
      },

      -- -----------------------------------------------------------------------
      -- COMPLETION - Cửa sổ gợi ý chính
      -- Source: config/completion/
      -- -----------------------------------------------------------------------
      completion = {

        -- Menu danh sách gợi ý (Source: config/completion/menu.lua)
        menu = {
          border = "rounded",
          max_height = 12, -- Tăng từ mặc định 10 để thấy nhiều gợi ý hơn
          draw = {
            -- Bật treesitter highlighting cho LSP items để code highlight đẹp
            treesitter = { "lsp" },
            -- Layout: [icon] [tên + mô tả]  [nguồn: LSP/Snippet/Buffer]
            -- source_name giúp Fresher biết mỗi gợi ý đến từ đâu
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },

        -- Trigger - Điều kiện bật cửa sổ (Source: config/completion/trigger.lua)
        trigger = {
          -- Backspace cũng tiếp tục gợi ý, hỗ trợ Fresher hay sửa lỗi gõ
          show_on_backspace = true,
        },

        -- Cửa sổ tài liệu bên cạnh (Source: config/completion/documentation.lua)
        documentation = {
          -- auto_show và auto_show_delay_ms đã được LazyVim bật sẵn (200ms)
          -- Chỉ tùy chỉnh kích thước cửa sổ cho thoải mái đọc docs
          window = {
            border = "rounded",
            max_width = 90,  -- Rộng hơn mặc định (80) để đọc docs thoải mái
            max_height = 25, -- Cao hơn mặc định (20)
          },
        },

        -- Hành vi sau khi chọn gợi ý (Source: config/completion/accept.lua)
        accept = {
          -- Tự động thêm () sau khi chọn function/method
          -- VD: chọn `useState` → tự ra `useState()`, con trỏ vào trong
          auto_brackets = { enabled = true },
        },
      },

      -- -----------------------------------------------------------------------
      -- SIGNATURE HELP - Chữ ký hàm khi gõ dấu mở ngoặc
      -- Source: config/signature.lua
      -- VD: gõ `useState(` → hiện `useState<S>(initialState: S | (() => S))`
      -- -----------------------------------------------------------------------
      signature = {
        enabled = true, -- LazyVim mặc định là false, bật lên cho Fresher
        window = { border = "rounded" },
      },

      -- -----------------------------------------------------------------------
      -- SOURCES - Nguồn cung cấp gợi ý
      -- Source: config/sources.lua + README blink-ripgrep.nvim
      -- -----------------------------------------------------------------------
      sources = {
        -- Thêm "ripgrep" vào danh sách nguồn mặc định
        -- Theo README gốc: phải khai báo cả ở `default` lẫn `providers`
        default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
        providers = {
          supermaven = { enabled = false }, -- Tắt trong menu, dùng qua toggle riêng
          lsp        = { score_offset = 100 }, -- LSP luôn ưu tiên cao nhất
          buffer     = { score_offset = -5  }, -- Buffer ưu tiên thấp để không che LSP
          -- snippets: KHÔNG override, LazyVim đã kết nối với LuaSnip tự động

          -- Ripgrep: external provider - BẮT BUỘC có module + name theo tài liệu gốc
          -- Tìm kiếm từ khóa trong toàn bộ project, giúp không bị quên tên biến/hàm
          ripgrep = {
            module = "blink-ripgrep",   -- tên module Lua của plugin
            name   = "Ripgrep",         -- tên hiển thị trong cột source_name
            score_offset = -8,          -- ưu tiên thấp hơn buffer để không che LSP/Snippet
            -- Cấu hình tùy chọn theo README:
            opts = {
              -- Chỉ tìm khi từ khoá >= 3 ký tự để tránh lag khi gõ chữ cái đầu
              prefix_min_len = 3,
              -- Ưu tiên git grep (nhanh hơn rg), fallback về rg nếu không có git
              backend = { use = "gitgrep-or-ripgrep" },
              -- Tìm từ thư mục chứa .git hoặc package.json
              project_root_marker = { ".git", "package.json" },
            },
          },
        },
      },

      -- -----------------------------------------------------------------------
      -- KEYMAP - Phím tắt (Trường phái 2: Phân tách rạch ròi chuẩn Senior)
      -- -----------------------------------------------------------------------
      keymap = {
        preset = "default",
        
        -- Enter: Chỉ dùng để Chốt gợi ý (Accept)
        ["<CR>"]    = { "accept", "fallback" },
        
        -- Điều hướng Menu Gợi ý: Dùng <C-n> (Next - đi xuống) và <C-p> (Prev - đi lên)
        -- (Hai phím này đã được tự động gán sẵn bởi `preset = "default"`)

        -- Tab: CHỈ DÙNG để nhảy tới ô tiếp theo trong Form (Snippet)
        ["<Tab>"]   = { "snippet_forward", "fallback" },
        -- Shift-Tab: CHỈ DÙNG để nhảy lùi lại ô trước trong Form
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      -- -----------------------------------------------------------------------
      -- CMDLINE - Gợi ý khi gõ lệnh Vim (dấu :)
      -- -----------------------------------------------------------------------
      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
      },
    },
  },
}
