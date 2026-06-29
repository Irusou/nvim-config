return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "javascript", "typescript", "go", "html", "prisma" },

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}
