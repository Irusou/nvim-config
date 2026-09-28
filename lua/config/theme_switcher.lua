-- theme_switcher.lua
local M = {}

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

return M
