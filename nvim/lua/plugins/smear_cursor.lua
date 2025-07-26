return {
  "sphamba/smear-cursor.nvim",
  opts = {
    stiffness = 0.5,
    trailing_stiffness = 0.49,
    never_raw_over_target = false,
  },

  config = function(_, opts)
    require("smear_cursor").setup(opts)
  end,
}
