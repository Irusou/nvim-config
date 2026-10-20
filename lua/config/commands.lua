local switcher = require("config.theme_switcher")
switcher.load_theme()

-- theme related command
vim.api.nvim_create_user_command("Theme", function(opts)
  if opts.args ~= "" then
    switcher.set_theme(opts.args)
  else
    switcher.pick_theme()
  end
end, { nargs = "?", complete = function() return switcher.themes end })

-- open an image command
vim.api.nvim_create_user_command("Img", function(opts)
  local filename = opts.args

  if filename == "" then
    filename = vim.fn.expand("<cfile>")
  end

  vim.fn.jobstart({ "cmd.exe", "/c", "start", "", filename }, { detach = true })
end, {
  nargs = "?", complete = "file" })
