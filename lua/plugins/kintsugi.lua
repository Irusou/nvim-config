return {
  "metalelf0/kintsugi-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kintsugi").setup({
      variant = "flared", -- "dark" | "flared"
      terminal_colors = true,
      bold_keywords = true,
      italic_comments = true,
    })
    vim.cmd.colorscheme("kintsugi-flared") -- or "kintsugi-flared"
  end,
}
