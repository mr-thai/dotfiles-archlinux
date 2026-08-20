return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- ==========================================
        -- CÁC CÔNG CỤ ĐANG ĐƯỢC KÍCH HOẠT TỰ ĐỘNG CÀI
        -- ==========================================
        "prettier", -- Formatter tiêu chuẩn cho Frontend (JS/TS/HTML/CSS/JSON/Markdown)
        "eslint_d", -- Linter siêu nhanh cho JS/TS
        "black",    -- Formatter tiêu chuẩn cho Python
        "isort",    -- Tự động sắp xếp các dòng import cho Python
        "flake8",   -- Linter bắt lỗi cú pháp và style cho Python
        "stylua",   -- Formatter chuẩn cho Lua
        "marksman", -- LSP cho Markdown hỗ trợ liên kết ghi chú

        -- ==========================================
        -- DANH MỤC CÁC GÓI MASON PHỔ BIẾN (BOILERPLATE)
        -- (Bỏ comment tên gói để Mason tự động tải về cài đặt khi khởi động)
        -- ==========================================

        -- --- LSP SERVERS (Language Servers) ---
        -- "lua-language-server",           -- LSP cho Lua (lua_ls)
        -- "vtsls",                         -- LSP tối ưu siêu tốc cho TypeScript / JavaScript
        -- "typescript-language-server",    -- LSP tiêu chuẩn cho TypeScript / JavaScript (ts_ls)
        -- "pyright",                       -- LSP phân tích tĩnh và type check cho Python
        -- "basedpyright",                  -- LSP Python nâng cao (fork của pyright)
        -- "ruff-lsp",                      -- LSP phân tích và lint nhanh cho Python
        -- "gopls",                         -- LSP chính thức cho Go từ Google
        -- "rust-analyzer",                 -- LSP chính thức cho Rust
        -- "clangd",                        -- LSP mạnh mẽ cho C / C++ (LLVM)
        -- "html-lsp",                      -- LSP cho HTML
        -- "css-lsp",                       -- LSP cho CSS / SCSS / LESS
        -- "tailwindcss-language-server",   -- LSP gợi ý class Tailwind CSS
        -- "emmet-language-server",         -- LSP mở rộng snippet HTML/JSX cho Emmet
        -- "json-lsp",                      -- LSP cho JSON kèm schema validation
        -- "yaml-language-server",          -- LSP cho YAML / Docker Compose / Kubernetes
        -- "taplo",                         -- LSP & Formatter cho file TOML
        -- "bash-language-server",          -- LSP cho Shell / Bash script
        -- "dockerfile-language-server",    -- LSP cho Dockerfile
        -- "docker-compose-language-service", -- LSP cho Docker Compose

        -- --- FORMATTERS (Công cụ định dạng code) ---
        -- "prettierd",                     -- Prettier daemon chạy siêu nhanh
        -- "shfmt",                         -- Formatter cho Shell script (Bash/Sh)
        -- "gofumpt",                       -- Formatter nghiêm ngặt hơn gofmt cho Go
        -- "goimports",                     -- Tự động thêm/xoá/sắp xếp import cho Go
        -- "clang-format",                  -- Formatter cho C / C++ / Java / C#
        -- "rustfmt",                       -- Formatter chuẩn cho Rust
        -- "sql-formatter",                 -- Formatter cho câu lệnh SQL
        -- "sqlfluff",                      -- Linter và Formatter toàn diện cho SQL

        -- --- LINTERS (Công cụ phân tích và bắt lỗi code) ---
        -- "eslint-lsp",                    -- ESLint chạy dưới dạng LSP Server
        -- "ruff",                          -- Linter + Formatter Rust siêu nhanh cho Python
        -- "shellcheck",                    -- Linter phân tích bắt lỗi logic cho Shell script
        -- "golangci-lint",                 -- Bộ tổng hợp linter hàng đầu cho Go
        -- "markdownlint-cli2",             -- Linter kiểm tra cấu trúc file Markdown
        -- "yamllint",                      -- Linter kiểm tra tính hợp lệ của file YAML
        -- "jsonlint",                      -- Linter kiểm tra cú pháp file JSON
        -- "hadolint",                      -- Linter kiểm tra Dockerfile

        -- --- DEBUGGERS (DAP Adapters) ---
        -- "debugpy",                       -- Debugger cho Python
        -- "delve",                         -- Debugger cho Go
        -- "codelldb",                      -- Debugger cho C, C++, Rust
        -- "js-debug-adapter",              -- Debugger cho JavaScript / TypeScript
      })
    end,
  },
}
