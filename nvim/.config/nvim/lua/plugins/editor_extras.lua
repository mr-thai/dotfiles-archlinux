-- Plugin bổ sung: surround, yazi, go tools, python imports

return {
  -- nvim-surround: Thêm/xóa/thay surroundings (quotes, brackets, tags...)
  -- Dùng: ys{motion}{char} thêm, ds{char} xóa, cs{old}{new} thay
  -- Ví dụ: ysiw" → bọc từ trong "", ds" → xóa "", cs"' → đổi "" thành ''
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true, -- Dùng default config, đủ dùng ngay
  },


}
