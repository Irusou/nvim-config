return
{
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- optional, only needed for notification popups
  },
  opts = {
    cmdline = { enabled = true, view = "cmdline_popup" },
    messages = { enabled = true },
    notify = { enabled = true }, -- routes vim.notify (theme switcher, formatter, mason) through nvim-notify
    popupmenu = { enabled = false, backend = "nui" },

    lsp = {
      progress = { enabled = true },   -- shows roslyn / lsp loading progress
      hover = { enabled = true },
      signature = { enabled = false }, -- keep off if your completer already shows signatures
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },

    presets = {
      lsp_doc_border = true,
      long_message_to_split = true,
    },

    views = {
      cmdline_popup = {
        position = { row = "88%", col = "50%" },
        size = { width = 60, height = "auto" },
        border = { style = "rounded", padding = { 0, 1 } },
      },
      popupmenu = {
        relative = "editor",
        position = { row = "60%", col = "50%" },
        size = { width = 60, height = 10 },
        border = { style = "rounded", padding = { 0, 1 } },
      },
    },
  }
}
