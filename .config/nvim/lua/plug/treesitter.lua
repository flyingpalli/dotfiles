return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ':TSUpdate',
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      local configs = require 'nvim-treesitter.configs'
      local to = Key.TS.textobjects
      local is = Key.TS.incremental_selection
      configs.setup {
        ensure_installed = { 'c', 'lua', 'vim', 'haskell', 'go', 'python', 'cpp' },
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
        sync_install = true,
        incremental_selection = { enable = true, keymaps = is },
        textobjects = {
        select = { enable = true, lookahead = true, keymaps = to.select },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = to.move.goto_next_start,
          goto_next_end = to.move.goto_next_end,
          goto_previous_start = to.move.goto_previous_start,
          goto_previous_end = to.move.goto_previous_end,
        },
        swap = {
          enable = true,
          swap_next = to.swap.next,
          swap_previous = to.swap.previous,
        },
        lsp_interop = {
          enable = true,
          border = S.Border,
          peek_definition_code = to.lsp_interop,
        },
      }}
    end
  }
