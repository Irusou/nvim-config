vim.env.CC = "gcc"
vim.env.CXX = "g++"
vim.diagnostic.config({ virtual_text = true })

require("config.options")
require("config.lazy")
require("config.keymaps")
