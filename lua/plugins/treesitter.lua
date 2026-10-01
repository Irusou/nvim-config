return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
cmd = { "TSInstall", "TSUpdate", "TSInstallInfo", "TSUninstall" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "javascript", "typescript", "tsx", "go", "html", "css",
          "prisma", "c_sharp", "razor",
          "c", "rust", "python",
        },

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
