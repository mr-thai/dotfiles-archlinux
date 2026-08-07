return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)


            local function supermaven_status()
                local api = require("supermaven-nvim.api")
                if api.is_running() then return "󰚩 AI" end
                return "󱚧 AI"
            end

            local function harpoon_component()
                local ok, harpoon = pcall(require, "harpoon")
                if not ok then return "" end
                local length = harpoon:list():length()
                if length == 0 then return "" end
                
                local marks = {}
                for i = 1, length do
                    local item = harpoon:list():get(i)
                    if item and item.value then
                        local name = vim.fn.fnamemodify(item.value, ":t")
                        table.insert(marks, string.format("%d:%s", i, name))
                    end
                end
                return "󰛢 " .. table.concat(marks, " | ")
            end

            -- Chèn Harpoon vào thanh trạng thái bên trái (lualine_c)
            opts.sections.lualine_c = opts.sections.lualine_c or {}
            table.insert(opts.sections.lualine_c, {
                harpoon_component,
                color = { fg = "#f9e2af", gui = "bold" },
            })


            -- Khối Y: Đè lại hoàn toàn để nó không tự động dính thêm cái location (21:1) vào nữa
            opts.sections.lualine_y = {
                {
                    supermaven_status,
                    color = { fg = "#89b4fa", gui = "bold" },
                },
                { "progress", padding = { left = 1, right = 1 } }
            }

            -- Khối Z: Giữ nguyên Dòng:Cột (Line:Column) cơ bản không có text thừa
            opts.sections.lualine_z = { "location" }
        end,
    }
}
