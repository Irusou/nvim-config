local switcher = require("config.theme_switcher")
switcher.load_theme()

vim.api.nvim_create_user_command("Theme", function(opts)
  if opts.args ~= "" then
    switcher.set_theme(opts.args)
  else
    switcher.pick_theme()
  end
end, { nargs = "?", complete = function() return switcher.themes end })
