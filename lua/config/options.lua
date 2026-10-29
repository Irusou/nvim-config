vim.g.mapleader = " "
vim.env.CC = "gcc"
vim.env.CXX = "g++"

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.wrap = true
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.updatetime = 250
opt.timeoutlen = 300

-- opt.cursorline = true
-- opt.cursorcolumn = true

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
