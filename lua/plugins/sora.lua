return {
  "Aejkatappaja/sora",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,                    -- transparent background (also strips float/statusline bg)
    italic = true,                          -- italics globally
    italic_comments = true,                 -- italics for comments (ignored if italic = false)

    on_colors = function(colors) end,       -- override palette before highlights build
    on_highlights = function(hl, colors) end, -- override highlight groups after they build
  },
  config = function(_, opts)
    require("sora").setup(opts)
    vim.cmd("colorscheme sora")
  end,
}
