return {
  'nvim-lua/plenary.nvim',
  lazy = false,
  config = function()
    local plenary = require 'plenary'

    local async = require 'plenary.async'
  end,
}
