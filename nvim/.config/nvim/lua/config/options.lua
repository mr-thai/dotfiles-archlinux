-- ==========================================
-- CÁC CẤU HÌNH CÁ NHÂN (Ghi đè mặc định LazyVim)
-- ==========================================
vim.opt.showtabline = 0    -- Ẩn hoàn toàn tabline ở cạnh trên (vì dùng [b ]b để chuyển file)
vim.opt.swapfile = false   -- Không sinh ra file rác .swp

-- ==========================================
-- ĐỊNH VỊ GỐC DỰ ÁN (Bỏ "lsp" so với mặc định)
-- ==========================================
vim.g.root_spec = { ".git", "lua", "cwd" }

-- ==========================================
-- AUTO-DETECT PYTHON 3 HOST (Tăng tốc nạp Python)
-- ==========================================
local python_path = vim.fn.exepath("python3")
if python_path == "" then
    python_path = vim.fn.exepath("python")
end

if python_path ~= "" then
    vim.g.python3_host_prog = python_path
end
