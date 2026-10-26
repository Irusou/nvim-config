return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          icons_enabled = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn", "hint", "info" },
              colored = true,
              update_in_insert = true,
              always_visible = false,
            },

          },
          lualine_x = { 'encoding', 'filename', { 'filetype', icon_only = true } },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = { 'fileformat' },
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  }
}
