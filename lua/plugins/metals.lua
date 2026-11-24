-- lua/plugins/metals.lua
return {
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "saghen/blink.cmp",
      "mfussenegger/nvim-dap",
      { "j-hui/fidget.nvim", opts = {} }, -- shows Metals progress
    },
    opts = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        showInferredType = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }

      -- Let fidget handle status instead of Metals' own status bar
      metals_config.init_options.statusBarProvider = "off"

      -- blink.cmp capabilities
      metals_config.capabilities = require("blink.cmp").get_lsp_capabilities(metals_config.capabilities)

      metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()

        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "References")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>mc", function()
          require("telescope").extensions.metals.commands()
        end, "Metals commands")
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = group,
      })
    end,
  },
}
