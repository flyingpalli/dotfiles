return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = { "InsertCharPre", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    { "hrsh7th/cmp-nvim-lua", ft = "lua" },
    { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
    "hrsh7th/cmp-buffer",
    "amarakon/nvim-cmp-buffer-lines",
    { url = "https://codeberg.org/FelipeLema/cmp-async-path" },
    {
      "L3MON4D3/LuaSnip",
      build = "make",
      dependencies = { "saadparwaiz1/cmp_luasnip" },
    },
    {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    { "onsails/lspkind.nvim" },
  },
  opts = function()
    local ls = require("luasnip")
    local lspkind = require("lspkind")
    local cmp = require("cmp")
    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

      -- Search
      -- stylua: ignore start
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "buffer", keyword_length = 1, max_item_count = 10 } }),
        view = { entries = { name = "wildmenu", separator = " │ " } },
      })

      -- Command
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<C-j>"] = cmp.mapping({ c = function() vim.api.nvim_feedkeys(t("<Down>"), "n", true) end, }),
          ["<C-k>"] = cmp.mapping({ c = function() vim.api.nvim_feedkeys(t("<Up>"), "n", true) end, }),
          ["<C-y>"] = cmp.mapping({ c = function()
            if cmp.visible() then
              if not cmp.get_selected_entry() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
              cmp.confirm({ select = true })
            else
              cmp.complete()
            end
          end }),
        }),
        sources = cmp.config.sources(
          { { name = "cmdline", keyword_length = 1, max_item_count = 20 } },
          { { name = "async_path", keyword_length = 2, max_item_count = 20 } }
        ),
        view = { entries = { name = "custom" } },
      })
    -- stylua: ignore end

    -- Main
    return {
      enabled = function()
        local ctx = require("cmp.config.context")
        if vim.bo.buftype == "prompt" then
          return false
        else
          return not (
            ctx.in_treesitter_capture("comment")
            and ctx.in_syntax_group("Comment")
          )
        end
      end,
      snippet = { expand = function(args) ls.lsp_expand(args.body) end },
      completion = { autocomplete = false },
      performance = { debounce = 10, throttle = 10, async_budget = 5 },
      sorting = {
        priority_weight = 4,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.scopes,
          cmp.config.compare.offset,
          cmp.config.compare.locality,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
          -- cmp.config.compare.sort_text,
          -- cmp.config.compare.recently_used,
        },
      },
        -- stylua: ignore start
        -- Source groups: LSP & snippet, buffer, path, vimtex.
        sources = cmp.config.sources(
          { { name = "nvim_lsp",                keyword_length = 1, max_item_count = 50, priority = 900, group_index = 1,
                option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } } },
            { name = "nvim_lsp_signature_help", keyword_length = 1, max_item_count = 10, priority = 875, group_index = 1 },
            { name = "luasnip",                 keyword_length = 2, max_item_count = 10, priority = 850, group_index = 1 },
            { name = "nvim_lua",                keyword_length = 3, max_item_count = 10, priority = 600, group_index = 1 } },
          { { name = "buffer",                  keyword_length = 1, max_item_count = 10, priority = 900, group_index = 2 },
            { name = "buffer-lines",            keyword_length = 2, max_item_count = 10, priority = 875, group_index = 2 } },
          { { name = "async_path",              keyword_length = 1, max_item_count = 10, priority = 900, group_index = 3,
                option = { trailing_slash = true, show_hidden_files_by_default = true } } },
          { { name = "vimtex",                  keyword_length = 2, max_item_count = 20, priority = 500 } }
          -- { { name = "treesitter", keyword_length = 2, max_item_count = 20, priority = 600 } }
        ),
        window = {
          completion = cmp.config.window.bordered({ scrollbar = true, border = S.Border }),
          documentation = cmp.config.window.bordered({ scrollbar = true, border = S.Border }),
        },
        mapping = {
          ["<C-n>"] = function()
            if cmp.visible() then cmp.select_next_item({ behaviour = cmp.SelectBehavior.Select }) else cmp.complete() end
          end,
          ["<C-p>"] = function()
            if cmp.visible() then cmp.select_prev_item({ behaviour = cmp.SelectBehavior.Select }) else cmp.complete() end
          end,
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-'>"] = function()
            if not cmp.visible() then cmp.complete() else cmp.complete_common_string() end
          end,
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping({
            i = function(fb)
              if cmp.visible() then
                if not cmp.get_selected_entry() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              elseif ls.expand_or_locally_jumpable() then
                ls.expand_or_jump()
              else
                fb()
              end
            end,
          }),
        },
      -- stylua: ignore end
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = function() return math.floor(0.75 * vim.o.columns) end,
          menu = {
            nvim_lsp = "[LSP]",
            nvim_lua = "[Vim]",
            luasnip = "[Snip]",
            async_path = "[Path]",
            buffer = "[Buf]",
            ["buffer-lines"] = "[Line]",
            cmdline = "[CMD]",
            vimtex = "[Tex]",
          },
        }),
      },
    }
  end,
}
