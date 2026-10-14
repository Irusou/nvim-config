return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            -- VCS / editor
            "^%.git/",
            "%.idea/",
            "%.vscode/",

            -- JS / TS / React / Node
            "node_modules/",
            "dist/",
            "build/",
            "%.next/",
            "coverage/",
            "%.min%.js",
            "package%-lock%.json",
            "yarn%.lock",
            "pnpm%-lock%.yaml",
            "%.js%.map$",
            "%.css%.map$",

            -- Java
            "target/",
            "%.gradle/",
            "%.class$",
            "%.jar$",

            -- Rust
            "target/", -- shared with Java/Maven
            "Cargo%.lock",

            -- Go
            "vendor/",

            -- Python
            "__pycache__/",
            "%.pyc$",
            "%.venv/",
            "venv/",
            "%.mypy_cache/",
            "%.ruff_cache/",
            "%.pytest_cache/",
            "%.egg%-info/",

            -- C
            "%.o$",
            "%.a$",
            "%.so$",
            "%.out$",
            "%.cache/",

            -- C#
            "bin/",
            "obj/",
            "%.dll$",
            "%.exe$",
            "%.pdb$",
          },
        },
      })

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fa", function()
        builtin.find_files({ hidden = true, no_ignore = true })
      end)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
    end,
  },
}
