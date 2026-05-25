require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "lua_ls",
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

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "rust_analyzer",
  "gopls",
  "jsonls",
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,     -- gutter icons
  underline = true, -- underline errors
  update_in_insert = false,
  severity_sort = true,
})
