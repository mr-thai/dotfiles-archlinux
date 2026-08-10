local M = {}
local log_file = vim.fn.stdpath("cache") .. "/key_log.txt"
local ns = vim.api.nvim_create_namespace("AgentKeylogger")

M.is_running = false

M.toggle = function()
  if M.is_running then
    vim.on_key(nil, ns)
    M.is_running = false
    print("🛑 Đã dừng ghi phím. File lưu tại: " .. log_file)
  else
    local f = io.open(log_file, "a")
    if not f then
      print("❌ Không thể tạo file log!")
      return
    end

    f:write("\n\n--- 🚀 Phiên ghi phím mới: " .. os.date() .. " ---\n")
    
    M.is_running = true
    print("⏺️ Đang ghi lại các phím bạn bấm... (Gõ ':ToggleKeylogger' để dừng)")

    vim.on_key(function(key)
      if key and #key > 0 then
        -- Chuyển phím thô sang định dạng dễ đọc (vd: <CR>, <Esc>, <C-w>)
        local key_str = vim.fn.keytrans(key)
        f:write(key_str .. " ")
        f:flush()
      end
    end, ns)
  end
end

-- Tạo lệnh để gọi nhanh trong Nvim
vim.api.nvim_create_user_command("ToggleKeylogger", M.toggle, {})

return M
