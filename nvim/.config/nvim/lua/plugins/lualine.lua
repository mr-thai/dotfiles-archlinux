return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)

            -- Component hiển thị trạng thái GitHub Copilot an toàn 100%
            local function copilot_status()
                local ok, client = pcall(function()
                    local clients = vim.lsp.get_clients({ name = "copilot" })
                    return #clients > 0
                end)
                if ok and client then
                    return " Copilot"
                end
                return " Copilot"
            end

            opts.sections = opts.sections or {}
            opts.sections.lualine_c = opts.sections.lualine_c or {}
            
            -- Xóa các chèn thừa Harpoon, giữ lualine_c sạch sẽ
            opts.sections.lualine_y = {
                {
                    copilot_status,
                    color = function()
                        local clients = vim.lsp.get_clients({ name = "copilot" })
                        if #clients > 0 then
                            return { fg = "#a6e3a1", gui = "bold" } -- Xanh lá khi Copilot kết nối LSP
                        end
                        return { fg = "#6c7086", gui = "italic" } -- Xám khi tắt
                    end,
                },
                { "progress", padding = { left = 1, right = 1 } },
            }

            opts.sections.lualine_z = { "location" }
        end,
    }
}
