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
