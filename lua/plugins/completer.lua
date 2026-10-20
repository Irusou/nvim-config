return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      -- let noice own the cmdline popup and its menu
      cmdline = { enabled = true },

      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        menu = { border = "rounded" },
        documentation = {
          auto_show = true,
          window = { border = "rounded" },
        },
        ghost_text = { enabled = true },
      },

      sources = {
        default = { "lsp", "buffer", "path" },
      },
    },
  },
}
