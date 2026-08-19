local M = {}

local colors = {
  copy = "#f9e2af", -- Yellow
  delete = "#f38ba8", -- Red
  insert = "#a6e3a1", -- Green (Insert)
  visual = "#cba6f7", -- Mauve (Visual)
}
local opacity = 0.2
local ignore = { "NvimTree", "TelescopePrompt", "lazy", "snacks_dashboard" }

local function hex_rgb(hex)
  return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

local function blend(hex, base, a)
  local r1, g1, b1 = hex_rgb(base)
  local r2, g2, b2 = hex_rgb(hex)
  local r = math.floor(r1 + (r2 - r1) * a)
  local g = math.floor(g1 + (g2 - g1) * a)
  local b = math.floor(b1 + (b2 - b1) * a)
  return string.format("#%02x%02x%02x", r, g, b)
end

local function bg_color()
  local hl = vim.api.nvim_get_hl_by_name("Normal", {})
  if hl.background then
    return string.format("#%06x", hl.background)
  end
  return "#1e1e2e"
end

local groups = {}
local function ensure_groups()
  if not next(groups) then
    local base = bg_color()
    for scene, hex in pairs(colors) do
      local name = "Mode" .. scene:sub(1, 1):upper() .. scene:sub(2) .. "CursorLine"
      vim.api.nvim_set_hl(0, name, { bg = blend(hex, base, opacity) })
      groups[scene] = name
    end
  end
end

local function get_scene()
  if vim.tbl_contains(ignore, vim.bo.filetype) then
    return nil
  end
  local mode = vim.fn.mode(1)
  if mode:find("^i") then
    return "insert"
  elseif mode:find("^R") then
    return "delete"
  elseif mode:find("^v") or mode:find("^V") or mode:find("^\22") then
    return "visual"
  elseif mode:find("^n") then
    local op = vim.v.operator
    if op ~= "" then
      if op:match("[yY]") then
        return "copy"
      elseif op:match("[cCdDxX~]") then
        return "delete"
      end
    end
  end
  return nil
end

local function apply()
  ensure_groups()
  local win = vim.api.nvim_get_current_win()
  local scene = get_scene()
  vim.wo[win].winhighlight = "CursorLine:" .. (scene and groups[scene] or "CursorLine")
end

local group = vim.api.nvim_create_augroup("mode_highlight", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", { group = group, callback = apply })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "ColorScheme" }, { group = group, callback = apply })
vim.api.nvim_create_autocmd("WinLeave", {
  group = group,
  callback = function()
    vim.wo[vim.api.nvim_get_current_win()].winhighlight = "CursorLine:CursorLine"
  end,
})

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"

return M