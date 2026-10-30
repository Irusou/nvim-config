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
          -- lualine_a = { { "mode", fmt = function(s) return s:sub(1, 1) end } },
          lualine_a = { "mode" },
          lualine_b = { { "branch", fmt = function(s) return #s > 15 and s:sub(1, 14) .. "…" or s end }, 'diff' },
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
          lualine_x = {
            {
              function()
                local text = require("gitblame").get_current_blame_text()
                local max = math.floor(vim.o.columns * 0.25) -- scale with window width
                return #text > max and text:sub(1, max - 1) .. "…" or text
              end,
              cond = function()
                local ok, gb = pcall(require, "gitblame")
                return ok and gb.is_blame_text_available() and vim.o.columns > 120
              end,
            },
            { 'filename', path = 4 },
          },
          lualine_y = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                local names = {}
                for _, c in ipairs(clients) do table.insert(names, c.name) end
                return " " .. table.concat(names, ", ")
              end,
            }, { 'filetype', icon_only = true }
          },
          lualine_z = { { 'location', padding = 0 } }
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
