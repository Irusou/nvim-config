return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
      char = "▏",
    },
    scope = {
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "NvimTree",
        "lazy",
        "mason",
        "markdown",
        "txt",
        "json",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end
}
