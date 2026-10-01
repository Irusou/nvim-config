return {
  -- Mason (installs LSPs/tools)
  {
    "williamboman/mason.nvim",
    config = true,
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "clangd",
        "css-lsp",
        "docker-compose-language-service",
        "docker-language-server",
        "dockerfile-language-server",
        "emmet-language-server",
        "gopls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "prisma-language-server",
        "python-lsp-server",
        "rust-analyzer",
        "typescript-language-server",
      },
    }
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = true,
  },
}
