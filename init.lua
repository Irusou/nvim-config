vim.env.CC = "gcc"
vim.env.CXX = "g++"
vim.diagnostic.config({ virtual_text = true })

require("config.options")
require("config.lazy")
require("config.keymaps")
local switcher = require("config.theme_switcher")

vim.api.nvim_create_user_command("Theme", function(opts)
  if opts.args ~= "" then
    switcher.set_theme(opts.args)
  else
    switcher.pick_theme()
  end
end, { nargs = "?", complete = function() return switcher.themes end })
