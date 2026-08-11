-- Cấu hình plugin mini.ai (Tăng cường text objects)
-- Mặc định LazyVim đã cài đặt và cấu hình sẵn, ta chỉ extend (mở rộng) thêm các object hữu ích.
-- Các text objects mặc định có sẵn (KHÔNG cần config): 
--   a(, a), a', a", a*, a<Space>, af (function), a? (user prompt), tags
-- Mappings mặc định:
--   around = 'a', inside = 'i'
--   around_next = 'an', inside_next = 'in' (object tiếp theo)
--   around_last = 'al', inside_last = 'il' (object trước đó)
--   goto_left = 'g[', goto_right = 'g]' (nhảy đến cạnh object)

return {
  {
    "nvim-mini/mini.ai",
    -- LazyVim tự động load plugin này nên không cần thiết lập thêm event.
    opts = function(_, opts)
      local ai = require("mini.ai")
      
      -- Tăng n_lines lên 100 để tìm text object trên phạm vi rộng hơn (mặc định là 50)
      opts.n_lines = 100
      
      -- Mở rộng các custom text objects
      opts.custom_textobjects = opts.custom_textobjects or {}
      
      -- af/if: function (hàm). LazyVim có thể đã định nghĩa ở `f`, nhưng ta định nghĩa rõ ràng.
      opts.custom_textobjects.f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
      
      -- ac/ic: class (lớp). LazyVim có thể đã có ở `c`, nhưng ta giữ chắc chắn.
      opts.custom_textobjects.c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
      
      -- aa/ia: argument (tham số). Ta ghi đè 'a' vốn dĩ là block của LazyVim để thành argument.
      -- Điều này rất hữu ích cho Fresher code JS/React/Python khi cần thay đổi params.
      opts.custom_textobjects.a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" })
      
      return opts
    end,
  },
}
