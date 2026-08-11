-- =============================================================================
-- flash.nvim - Di chuyển siêu tốc bằng nhãn ký tự
-- Tài liệu gốc: ~/.local/share/nvim/lazy/flash.nvim/README.md
-- Tính năng độc quyền của Neovim - VSCode không có tương đương
-- =============================================================================
--
-- HƯỚNG DẪN SỬ DỤNG (BẮT BUỘC ĐỌC):
-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  s       → Flash Jump: Gõ 1-2 ký tự → Chọn nhãn → Bay đến đó          │
-- │  S       → Flash Treesitter: Nhảy + chọn nguyên cả Node code           │
-- │  r       → Remote Flash: Yank/Delete ở chỗ xa (chỉ dùng trong pending) │
-- │  R       → Treesitter Search: Tìm + chọn node ở bất cứ đâu             │
-- │  <C-s>   → Toggle Flash trong khi đang dùng / để tìm kiếm              │
-- └─────────────────────────────────────────────────────────────────────────┘
--
-- VÍ DỤ THỰC TẾ:
--   - Muốn đến dòng có chữ "useState": bấm s → gõ "us" → chọn nhãn
--   - Muốn copy một function từ xa: bấm y → bấm r → gõ tên hàm → chọn nhãn → iw
--   - Muốn chọn cả một block if/for: bấm S → chọn nhãn của node đó

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",

    ---@type Flash.Config
    -- Tất cả opts bên dưới đều đọc từ README mục "Default Settings"
    opts = {

      -- Bộ ký tự nhãn - chỉ dùng hàng home row (asdf ghkl) để ngón tay không rời bàn phím
      -- README gốc: `labels = "asdfghjklqwertyuiopzxcvbnm"` (mặc định)
      -- Tùy chỉnh: ưu tiên các phím dễ với ngón tay nhất
      labels = "asdfghjklqwertyuiop",

      search = {
        -- Tìm trên nhiều cửa sổ (split) cùng lúc - README: `multi_window = true`
        multi_window = true,
        -- Tìm chính xác (không phải regex) - nhanh và dễ đoán nhất cho Fresher
        -- README: mode = "exact" | "search" | "fuzzy"
        mode = "exact",
      },

      jump = {
        -- Lưu vị trí vào jumplist để có thể <C-o> quay lại - README: `jumplist = true`
        jumplist = true,
        -- Tự động nhảy khi chỉ có 1 kết quả - tắt để không bị bất ngờ
        -- README: `autojump = false`
        autojump = false,
        -- Xóa highlight sau khi nhảy xong cho màn hình sạch sẽ
        -- README: `nohlsearch = false` (mặc định), bật lên để gọn hơn
        nohlsearch = true,
      },

      label = {
        -- Nhãn hiện SAU từ khớp (mặc định) - dễ đọc hơn
        -- README: `after = true`, `before = false`
        after = true,
        before = false,
        -- Tự ưu tiên nhãn gần con trỏ nhất → ít phải di chuyển mắt
        -- README: `distance = true`
        distance = true,
        -- Bật màu rainbow cho nhãn Treesitter để dễ phân biệt node levels
        -- README: `rainbow = { enabled = false, shade = 5 }`
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },

      highlight = {
        -- Backdrop: làm mờ toàn bộ màn hình còn lại khi Flash đang chạy
        -- Giúp Fresher tập trung vào các nhãn - README: `backdrop = true`
        backdrop = true,
      },

      modes = {
        -- Chế độ f/t/F/T - tăng cường phím di chuyển cơ bản của Vim
        -- README: modes.char
        char = {
          enabled = true,
          -- Bật nhãn jump cho f/t khi dùng trong operator mode (ví dụ: df{label})
          -- README: `jump_labels = false` (mặc định), bật lên cho tiện
          jump_labels = true,
          -- Tìm trên nhiều dòng thay vì chỉ dòng hiện tại
          -- README: `multi_line = true`
          multi_line = true,
          -- Loại trừ các phím điều hướng khỏi nhãn để không xung đột
          -- README: `label = { exclude = "hjkliardc" }`
          label = { exclude = "hjkliardc" },
        },

        -- Chế độ tích hợp với / và ? tìm kiếm thông thường
        -- Tắt để không làm rối khi mới học - bật bằng <C-s> khi cần
        -- README: `modes.search.enabled = false` (mặc định)
        search = {
          enabled = false,
        },

        -- Chế độ Treesitter - chọn code theo cấu trúc ngữ nghĩa
        -- README: modes.treesitter
        treesitter = {
          -- Bật rainbow để phân biệt các cấp độ node khác nhau
          label = {
            before = true,
            after = true,
            style = "inline", -- README: style = "inline"
          },
        },
      },

      -- Thanh prompt hiện ở dưới cùng màn hình khi Flash đang chạy
      -- README: prompt.enabled = true
      prompt = {
        enabled = true,
        prefix = { { "⚡ Flash: ", "FlashPromptIcon" } },
      },
    },

    -- Phím tắt theo đúng tài liệu gốc (README mục Installation)
    -- CẢNH BÁO từ README: PHẢI dùng `function()` thay vì string để dot-repeat hoạt động
    keys = {
      -- s: Jump - nhảy đến bất kỳ vị trí nào trên màn hình
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
      -- S: Treesitter - nhảy và chọn node code (if block, function, v.v.)
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- r: Remote - thực hiện thao tác ở vị trí xa (chỉ trong operator-pending mode)
      { "r", mode = "o",               function() require("flash").remote() end,             desc = "Flash Remote" },
      -- R: Treesitter Search - tìm và chọn node ở bất kỳ đâu
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },
      -- <C-s>: Toggle Flash trong khi đang dùng /? để tìm kiếm
      { "<c-s>", mode = { "c" },       function() require("flash").toggle() end,             desc = "Toggle Flash Search" },
    },
  },

  -- -------------------------------------------------------------------------
  -- Tích hợp Flash với Snacks Picker (bạn đang dùng snacks_picker)
  -- README gốc: mục "Snacks Picker integration"
  -- Cho phép bấm s trong cửa sổ Snacks Picker để Flash-jump đến kết quả
  -- -------------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              -- <A-s> trong insert mode của picker để Flash
              ["<a-s>"] = { "flash", mode = { "n", "i" } },
              -- s trong normal mode của picker để Flash
              ["s"] = { "flash" },
            },
          },
        },
        actions = {
          -- Định nghĩa action "flash" cho picker theo README gốc
          flash = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
        },
      },
    },
  },
}
