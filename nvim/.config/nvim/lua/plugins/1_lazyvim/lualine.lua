return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)

            -- Component hiển thị trạng thái GitHub Copilot an toàn 100%
            local function copilot_status()
                local ok, client = pcall(require, "copilot.client")
                if ok and client and not client.is_disabled() then
                    return " 󰚩 Copilot"
                end
                return " Copilot Off"
            end

            local function copilot_color()
                local ok, client = pcall(require, "copilot.client")
                if ok and client and not client.is_disabled() then
                    return { fg = "#a6e3a1", gui = "bold" } -- Xanh lá khi Copilot bật
                end
                return { fg = "#6c7086", gui = "italic" } -- Xám khi tắt
            end

            opts.sections = opts.sections or {}
            opts.sections.lualine_c = opts.sections.lualine_c or {}
            
            -- Giữ lualine_y sạch sẽ: status Copilot + tiến trình
            opts.sections.lualine_y = {
                {
                    copilot_status,
                    color = copilot_color,
                },
                { "progress", padding = { left = 1, right = 1 } },
            }

            opts.sections.lualine_z = { "location" }
        end,
    }
}
