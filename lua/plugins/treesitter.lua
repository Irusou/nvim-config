return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    ensure_installed = { "lua", "javascript", "typescript", "go", "html", "prisma", "c_sharp", "razor" },

    config = function()
      require("nvim-treesitter.configs").setup({


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
