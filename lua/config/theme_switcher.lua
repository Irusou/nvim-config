-- theme_switcher.lua
local M = {}

-- add themes after adding the plugin
M.themes = {
  "catppuccin",
  "vague",
}

M.current = 1

function M.set_theme(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify("Colorscheme failed: " .. name .. "\n" .. err, vim.log.levels.ERROR)
    return
  end
  M.save_theme(name)
  vim.notify("Theme: " .. name)
end

function M.next_theme()
  M.current = M.current % #M.themes + 1
  M.set_theme(M.themes[M.current])
end

function M.prev_theme()
  M.current = (M.current - 2) % #M.themes + 1
  M.set_theme(M.themes[M.current])
end

-- Fuzzy picker if you have telescope
function M.pick_theme()
  vim.ui.select(M.themes, { prompt = "Select theme:" }, function(choice)
    if choice then M.set_theme(choice) end
  end)
end

-- persistence (same as before)
local theme_file = vim.fn.stdpath("data") .. "/last_theme.txt"

function M.save_theme(name)
  local data_dir = vim.fn.stdpath("data")

  if vim.fn.isdirectory(data_dir) == 0 then
    vim.fn.mkdir(data_dir, "p")
  end

  local f, err = io.open(theme_file, "w")
  if not f then
    vim.notify("Failed to save theme: " .. tostring(err), vim.log.levels.ERROR)
    return
  end
  f:write(name)
  f:close()
end

function M.load_theme()
  local f = io.open(theme_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    if name then M.set_theme(name) end
  end
end

return M
