return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    cmdline = { enabled = true },

    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "hide" },
      -- ["<C-e>"] = { "hide", "fallback" },
      -- ["<Esc>"] = { "hide", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      menu = { border = "rounded" },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
      ghost_text = { enabled = true },
    },

    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },
  },
}
