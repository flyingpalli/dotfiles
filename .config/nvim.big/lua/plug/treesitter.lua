return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    local to = Key.TS.textobjects
    local is = Key.TS.incremental_selection
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "regex",
        "bash",
        "c",
        "cpp",
        "ocaml",
        "ocaml_interface",
        "menhir",
        "python",
        "rust",
        "go",
        "gomod",
        "gosum",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "hyprlang",
        "toml",
        "yaml",
        "html",
      },
      auto_install = false,
      matchup = { enable = true },
      highlight = {
        enable = true,
        disable = function(ft, buf)
          return F.IsLargeFile(buf)
            or ft == "latex"
            or vim.fn.win_gettype() == "command"
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "python" } },
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
      },
    })
  end,
}
