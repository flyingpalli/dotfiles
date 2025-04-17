return {
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          FloatBorder = { fg = colors.mauve },
          CursorLineNr = { fg = colors.mauve },
          Directory = { fg = colors.mauve },
        }
      end,
    }
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'catppuccin'
  end,
}
