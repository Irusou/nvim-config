require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "lua_ls",
    "emmet_language_server",
    "pyright",
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

vim.lsp.config('clangd', {
  cmd = { "C:/msys64/ucrt64/bin/clangd.exe" },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
  filetypes = { "python" }
})

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "rust_analyzer",
  "gopls",
  "jsonls",
  "emmet_language_server",
  "roslyn",
  "clangd",
  "pyright"
})
