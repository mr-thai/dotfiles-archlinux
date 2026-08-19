local M = {}

local delay = 200
local ns = vim.api.nvim_create_namespace("cursorword")
local timer, current = nil, nil

vim.api.nvim_set_hl(0, "CursorWord", { underline = true, sp = "#7f849c", default = true })

local function clear()
  if current then
    pcall(vim.api.nvim_buf_clear_namespace, current.buf, ns, 0, -1)
    current = nil
  end
end

local function update()
  if vim.api.nvim_get_mode().mode:match("^[vV]") then
    return
  end
  clear()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end
  local line, col = vim.fn.line("."), vim.fn.col(".")
  if col + #word - 1 <= 0 then
    return
  end
  vim.api.nvim_buf_add_highlight(0, ns, "CursorWord", line - 1, col - 1, col - 1 + #word)
  current = { buf = vim.api.nvim_get_current_buf() }
end

local function debounced()
  if timer then
    timer:stop()
  end
  timer = vim.uv.new_timer()
  timer:start(delay, 0, vim.schedule_wrap(update))
end

local group = vim.api.nvim_create_augroup("cursorword", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { group = group, callback = debounced })
vim.api.nvim_create_autocmd({ "BufLeave", "InsertLeave", "WinLeave" }, { group = group, callback = clear })

return M