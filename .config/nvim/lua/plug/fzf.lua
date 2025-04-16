return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  enabled = true,
  opts = {
    { 'skim', 'max-perf', 'telescope' },
    fzf_bin = '/home/linuxbrew/.linuxbrew/bin/fzf',
    fzf_opts = { ['--layout'] = 'reverse', ['--marker'] = false },
    defaults = { compat_warn = false, no_header = true, no_header_i = true },
    winopts = {
      header = false,
      height = 0.4,
      width = 0.8,
      row = 0.5,
      col = 0.5,
      border = S.Border,
      treesitter = { enabled = true },
      backdrop = 100,
      preview = {
        -- default = "bat",
        border = 'noborder',
        wrap = 'nowrap',
        hidden = 'hidden',
        vertical = 'down:50%',
        horizontal = 'right:50%',
        layout = 'horizontal',
        scrollbar = false,
        scrolloff = '-2',
        scrollchars = { '', '' },
      },
    },
    keymap = {
      builtin = {
        true,
        ['<M-Esc>'] = 'hide',
        ['<F1>'] = 'toggle-help',
        ['<F2>'] = 'toggle-fullscreen',
        -- Only valid with the "builtin" previewer
        ['<F3>'] = 'toggle-preview-wrap',
        ['<M-p>'] = 'toggle-preview',
        -- Rotate preview clockwise/counter-clockwise
        -- ["<F5>"] = "toggle-preview-ccw",
        -- ["<F6>"] = "toggle-preview-cw",
        -- `ts-ctx` binds require `nvim-treesitter-context`
        -- ["<F7>"] = "toggle-preview-ts-ctx",
        -- ["<F8>"] = "preview-ts-ctx-dec",
        -- ["<F9>"] = "preview-ts-ctx-inc",
        -- ["<S-Left>"] = "preview-reset",
        -- ["<S-down>"] = "preview-page-down",
        -- ["<S-up>"] = "preview-page-up",
        -- ["<M-S-down>"] = "preview-down",
        -- ["<M-S-up>"] = "preview-up",
      },
      fzf = {
        true,
        ['ctrl-z'] = 'abort',
        ['ctrl-u'] = 'unix-line-discard',
        ['ctrl-f'] = 'preview-page-down',
        ['ctrl-b'] = 'preview-page-up',
        ['ctrl-a'] = 'beginning-of-line',
        ['ctrl-e'] = 'end-of-line',
        ['alt-a'] = 'toggle-all',
        ['alt-p'] = 'toggle-preview',
      },
    },
    -- actions = {
    --   files = {
    --     ["default"] = require("fzf-lua").actions.file_edit_or_qf,
    --     ["ctrl-x"] = require("fzf-lua").actions.file_split,
    --     ["ctrl-v"] = require("fzf-lua").actions.file_vsplit,
    --     ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
    --     ["alt-q"] = require("fzf-lua").actions.file_sel_to_qf,
    --     ["alt-l"] = require("fzf-lua").actions.file_sel_to_ll,
    --   },
    --   buffers = {
    --     ["default"] = require("fzf-lua").actions.buf_edit,
    --     ["alt-x"] = require("fzf-lua").actions.buf_del,
    --     ["ctrl-x"] = require("fzf-lua").actions.buf_split,
    --     ["ctrl-v"] = require("fzf-lua").actions.buf_vsplit,
    --     ["ctrl-t"] = require("fzf-lua").actions.buf_tabedit,
    --   },
    -- },
    files = { winopts = { width = 0.4 } },
    oldfiles = { winopts = { width = 0.4 } },
    buffers = { winopts = { width = 0.4 } },
    helptags = {
      winopts = { width = 1.0, height = 0.75, row = 1.0, col = 0.0 },
    },
  },
}
