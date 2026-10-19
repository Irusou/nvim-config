return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          sections = {
            lualine_c = {
              "filename",
              "diagnostics",
            },
            lualine_x = {
              "encoding",
              "fileformat",
              "filetype",
              "lsp_progress",
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
          },
          icons_enabled = true,
          section_separators = "",
          component_separators = "",
          globalstatus = true,
        },
      })
    end,
  }
}
