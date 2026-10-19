return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
        },
      },
    },
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",

          ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

          ["<CR>"] = { "accept", "fallback" },
          ["<C-Space>"] = { "show" },
        },
        sources = {
          default = { "lsp", "buffer", "path" },
        },
      })
    end,
  },
}
