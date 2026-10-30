return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      -- Choose a preset style for diagnostic appearance
      -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
      preset = "powerline",

      -- Make diagnostic background transparent
      transparent_bg = false,

      -- Make cursorline background transparent for diagnostics
      transparent_cursorline = true,

      options = {
        set_arrow_to_diag_color = true,
        -- Throttle update frequency in milliseconds to improve performance
        -- Higher values reduce CPU usage but may feel less responsive
        -- Set to 0 for immediate updates (may cause lag on slow systems)
        throttle = 10,

        -- Minimum number of characters before wrapping long messages
        softwrap = 30,
        -- Enable diagnostics display in insert mode
        -- May cause visual artifacts; consider setting throttle to 0 if enabled
        enable_on_insert = true,

        -- Enable diagnostics display in select mode (e.g., during auto-completion)
        enable_on_select = true,

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
      virtual_lines = false, -- really cool but need some tweeks
      underline = true,
      signs = true,
      update_in_insert = true,
    }) -- Disable Neovim's default virtual text diagnostics
  end,
}
