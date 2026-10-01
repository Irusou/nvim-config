require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "lua_ls",
    "emmet_language_server",
  },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
  capabilities = capabilities
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities
})

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities
})

vim.lsp.config("gopls", {
  capabilities = capabilities
})

vim.lsp.config("jsonls", {
  capabilities = capabilities
})

vim.lsp.config("emmet_language_server", {
  capabilities = capabilities
})

vim.lsp.config("roslyn", {
  on_attach = function()
    print("This will run when the server attaches!")
  end,
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "rust_analyzer",
  "gopls",
  "jsonls",
  "emmet_language_server",
  "roslyn"
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,     -- gutter icons
  underline = true, -- underline errors
  update_in_insert = true,
  severity_sort = true,
})
