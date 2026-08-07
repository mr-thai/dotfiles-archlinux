return {
    -- Enable catppuccin with modern integrations
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false,
            show_end_of_buffer = false, -- show the '~' characters at the end of a buffer
            term_colors = true,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15,
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = { "bold" },
                keywords = { "italic" },
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            custom_highlights = function(colors)
                return {
                    -- Inlay Hints: chữ nghiêng, màu xanh dương nhạt, nền mờ phía sau
                    LspInlayHint = {
                        fg = colors.blue,
                        bg = colors.surface0,
                        style = { "italic" },
                    },
                    -- Màu cho các link trong Obsidian / Markdown
                    -- Dùng màu xanh ngọc (sapphire) in đậm để nổi bật vừa phải, không chói
                    RenderMarkdownWikiLink = {
                        fg = colors.sapphire,
                        style = { "bold" },
                    },
                    RenderMarkdownLink = {
                        fg = colors.sapphire,
                        style = { "bold" },
                    },
                    ["@markup.link.markdown_inline"] = {
                        fg = colors.sapphire,
                        style = { "bold" },
                    },
                    ["@markup.link.label.markdown_inline"] = {
                        fg = colors.sapphire,
                        style = { "bold" },
                    },
                    -- Highlight mờ và có nền tối cho code AI (Supermaven)
                    SupermavenSuggestion = {
                        fg = colors.surface2, -- Chữ xám mờ
                        bg = colors.crust,    -- Nền đen sẫm
                        style = { "italic" },
                    },
                }
            end,
            integrations = {
                cmp = true,
                blink_cmp = true,          -- Đồng bộ màu xịn xò cho menu AI và gợi ý code
                render_markdown = true,    -- Tối ưu màu sắc cho tài liệu Markdown
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                aerial = true,
                fzf = true,
                mason = true,
                noice = true,
                snacks = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                semantic_tokens = true,
                telescope = {
                    enabled = true,
                },
                treesitter_context = true,
                which_key = true,
            },
        },
    },

    -- Configure LazyVim to use catppuccin
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-mocha",
        },
    },
}
