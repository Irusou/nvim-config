return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      -- Choose a preset style for diagnostic appearance
      -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
      preset = "classic",
      options = {
        show_source = {
          enabled = false,
        },
        add_messages = {
          display_count = false,
        },
        multilines = {
          enabled = true,          -- Enable support for multiline diagnostic messages
          always_show = true,      -- Always show messages on all lines of multiline diagnostics
          trim_whitespaces = true, -- Remove leading/trailing whitespace from each line
          tabstop = 4,             -- Number of spaces per tab when expanding tabs
          -- Restrict which severities are shown on non-cursor lines
          -- With always_show = true: listed severities stay visible on every line,
          -- all other severities only appear on the cursor line
          severity = {
            vim.diagnostic.severity.ERROR,
            -- vim.diagnostic.severity.WARN,
            -- vim.diagnostic.severity.INFO,
            -- vim.diagnostic.severity.HINT,
          },
        },
      }
    })
    vim.diagnostic.config({
      virtual_text = false,
      underline = true,
      signs = true,
      update_in_insert = false,
    }) -- Disable Neovim's default virtual text diagnostics
  end,

}
