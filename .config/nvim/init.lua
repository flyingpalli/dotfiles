require 'util.static'
require 'core.opt'
require 'core.func'
require 'core.keys'
require 'lazyPalli'
if vim.g.neovide then
  require 'core.vide'
end

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
