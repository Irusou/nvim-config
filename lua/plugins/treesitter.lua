return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua", "javascript", "typescript", "tsx", "go", "html", "css",
        "prisma", "c_sharp", "razor", "c", "rust", "python",
        "markdown", "markdown_inline",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            local ft = vim.bo[args.buf].filetype
            local skip_indent = { cs = true }
            if not skip_indent[ft] then
              vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        end,
      })
    end,
  },
}
