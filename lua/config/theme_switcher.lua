-- theme_switcher.lua
local M = {}

-- add themes after adding the plugin
M.themes = {
  "catppuccin-latte",
  "catppuccin-mocha",
  "oh-lucy-evening",
  "oh-lucy",
  "vague",
  "bluloco-dark",
  "moonfly",
  "kanagawa-wave",
  "sora",
  "vercel",
  "oldworld",
  "palenight",
  "ayu",
  "togglebit"
}

M.current = 1

---------------------------------------------------------------
-- Persistence (theme + transparency in one JSON file)
---------------------------------------------------------------
local state_file = vim.fn.stdpath("data") .. "/theme_state.json"
local old_theme_file = vim.fn.stdpath("data") .. "/last_theme.txt" -- legacy

M.transparent = true                                               -- default on first run
local saved_theme = nil

local function read_state()
  -- new format
  if vim.fn.filereadable(state_file) == 1 then
    local lines = vim.fn.readfile(state_file)
    local ok, data = pcall(vim.json.decode, table.concat(lines, "\n"))
    if ok and type(data) == "table" then
      saved_theme = data.theme
      if type(data.transparent) == "boolean" then
        M.transparent = data.transparent
      end
      return
    end
  end
  -- migrate old last_theme.txt
  if vim.fn.filereadable(old_theme_file) == 1 then
    saved_theme = vim.fn.readfile(old_theme_file)[1]
  end
end

function M.save_state()
  local data_dir = vim.fn.stdpath("data")
  if vim.fn.isdirectory(data_dir) == 0 then
    vim.fn.mkdir(data_dir, "p")
  end
  local payload = vim.json.encode({
    theme = vim.g.colors_name or saved_theme,
    transparent = M.transparent,
  })
  local ok, err = pcall(vim.fn.writefile, { payload }, state_file)
  if not ok then
    vim.notify("Failed to save theme state: " .. tostring(err), vim.log.levels.ERROR)
  end
end

-- read at require-time so M.transparent is correct before any theme loads
read_state()

---------------------------------------------------------------
-- Transparency
---------------------------------------------------------------
-- dark themes you never want transparent, e.g. { ["moonfly"] = true }
M.force_opaque = {}

local groups = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder", "EndOfBuffer",
  "SignColumn", "LineNr", "LineNrAbove", "LineNrBelow", "CursorLineNr",
  "FoldColumn", "CursorLineSign", "CursorLineFold", "WinSeparator",
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
  "GitSignsAdd", "GitSignsChange", "GitSignsDelete",
}

local function clear_bg()
  for _, name in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    hl.bg, hl.ctermbg = nil, nil
    vim.api.nvim_set_hl(0, name, hl)
  end
end

function M.apply_transparency()
  local is_light = vim.o.background == "light"
  local forced = M.force_opaque[vim.g.colors_name]
  if M.transparent and not is_light and not forced then
    clear_bg()
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() vim.schedule(M.apply_transparency) end,
})

function M.toggle_transparency()
  M.transparent = not M.transparent
  -- reloading the colorscheme restores its opaque highlights when turned off
  pcall(vim.cmd.colorscheme, vim.g.colors_name)
  M.save_state()
  vim.notify("Transparency: " .. (M.transparent and "on" or "off"))
end

---------------------------------------------------------------
-- Theme switching
---------------------------------------------------------------
function M.set_theme(name, silent)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify("Colorscheme failed: " .. name .. "\n" .. err, vim.log.levels.ERROR)
    return
  end

  -- keep M.current in sync (fixes next/prev after restoring on startup)
  for i, t in ipairs(M.themes) do
    if t == name then
      M.current = i
      break
    end
  end

  M.save_state()
  if not silent then
    vim.notify("Theme: " .. name)
  end
end

function M.next_theme()
  M.current = M.current % #M.themes + 1
  M.set_theme(M.themes[M.current])
end

function M.prev_theme()
  M.current = (M.current - 2) % #M.themes + 1
  M.set_theme(M.themes[M.current])
end

---------------------------------------------------------------
-- Floating picker with live preview
---------------------------------------------------------------
function M.pick_theme()
  local original = vim.g.colors_name
  local done = false

  -- sizing
  local width = 0
  for _, t in ipairs(M.themes) do width = math.max(width, #t) end
  width = math.max(width + 8, 30)
  local height = #M.themes

  -- content: " ●  name" for the active theme, "    name" for the rest
  local lines, start_idx = {}, 1
  for i, name in ipairs(M.themes) do
    local active = name == original
    if active then start_idx = i end
    lines[i] = string.format(" %s  %s", active and "●" or " ", name)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  -- color the active marker
  local ns = vim.api.nvim_create_namespace("theme_picker")
  for i, name in ipairs(M.themes) do
    if name == original then
      vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 1, { end_col = 4, hl_group = "DiagnosticOk" })
    end
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " Themes ",
    title_pos = "center",
    footer = " <CR> select  <Esc> cancel ", -- needs Neovim 0.10+, delete these two lines on older versions
    footer_pos = "center",
  })
  vim.wo[win].cursorline = true
  vim.wo[win].winhighlight = "CursorLine:PmenuSel"
  vim.api.nvim_win_set_cursor(win, { start_idx, 0 })

  local function selected()
    return M.themes[vim.api.nvim_win_get_cursor(win)[1]]
  end

  local function close()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  local function confirm()
    done = true
    local name = selected()
    close()
    M.set_theme(name)
  end

  local function cancel()
    if done then return end
    done = true
    close()
    if vim.g.colors_name ~= original then
      pcall(vim.cmd.colorscheme, original)
    end
  end

  -- live preview (doesn't save state)
  local last = original
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = buf,
    callback = function()
      local name = selected()
      if name and name ~= last then
        last = name
        pcall(vim.cmd.colorscheme, name)
      end
    end,
  })

  -- clicking away or switching windows cancels
  vim.api.nvim_create_autocmd("BufLeave", { buffer = buf, once = true, callback = cancel })

  local map = function(key, fn)
    vim.keymap.set("n", key, fn, { buffer = buf, nowait = true })
  end
  map("<CR>", confirm)
  map("<Esc>", cancel)
  map("q", cancel)
end

function M.load_theme()
  if saved_theme then
    M.set_theme(saved_theme, true) -- silent on startup
  end
end

return M
