return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      properties = 0.15,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = { "underline" },
      functions = { "bold" },
      -- standout
      keywords = {},
      -- "fg=#"
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },

    color_overrides = {
      mocha = {
        text = "#F4CDE9",
        subtext1 = "#DEBAD4",
        subtext0 = "#C8A6BE",
        overlay2 = "#B293A8",
        overlay1 = "#9C7F92",
        overlay0 = "#866C7D",
        surface2 = "#705867",
        surface1 = "#5A4551",
        surface0 = "#44313B",

        base = "#352939",
        mantle = "#211924",
        crust = "#1a1016",
      },
    },

    custom_highlights = function()
      return {
        Visual = { bg = "#5a4d4d" },
        CursorLine = { bg = "none" },
        CursorColumn = { bg = "none" },
      }
    end,
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
