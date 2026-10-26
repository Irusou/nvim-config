local M = {}

local defaults = {
  templates_dir = vim.fs.joinpath(
    vim.fn.stdpath("config"),
    "lua",
    "templates"
  ),
}

local function read_file(path)
  local file = io.open(path, "r")

  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()

  return content
end

local function get_templates()
  local templates = {}
  local stat = vim.uv.fs_stat(defaults.templates_dir)

  if not stat or stat.type ~= "directory" then
    vim.notify(
      "Templates directory does not exist: " .. defaults.templates_dir,
      vim.log.levels.ERROR
    )
    return templates
  end

  -- Iterate over the directory entries.
  for name, type in vim.fs.dir(defaults.templates_dir) do
    if type == "file" and name:match("%.md$") then
      table.insert(templates, name)
    end
  end

  table.sort(templates)
  return templates
end

local function replace_placeholders(content, title)
  local values = {
    title = title,
    date = os.date("%Y-%m-%d"),
    time = os.date("%H:%M"),
    datetime = os.date("%Y-%m-%d %H:%M"),
  }

  return content:gsub("{{([%w_]+)}}", function(key)
    return values[key] or "{{" .. key .. "}}"
  end)
end

local function create_note(template_name, filename)
  if not filename or filename == "" then
    filename = vim.fn.input("Note name: ")
  end

  if filename == "" then
    print("Note creation cancelled.")
    return
  end

  -- Sanitize the filename for Windows.
  filename = filename:gsub('[<>:"/\\|?*]', "_")
  filename = filename:gsub("[%. ]+$", "")

  if filename == "" or filename == "." or filename == ".." then
    vim.notify("Invalid note name.", vim.log.levels.ERROR)
    return
  end

  -- Add .md if no extension was supplied.
  if not filename:match("%.md$") then
    filename = filename .. ".md"
  end

  local template_path = vim.fs.joinpath(
    M.config.templates_dir,
    template_name
  )

  local content = read_file(template_path)

  if not content then
    vim.notify(
      "Could not read template: " .. template_name,
      vim.log.levels.ERROR
    )
    return
  end

  -- Use the current file's directory, or cwd for unnamed buffers.
  local current_file = vim.api.nvim_buf_get_name(0)
  local target_dir

  if current_file ~= "" then
    target_dir = vim.fs.dirname(current_file)
  else
    target_dir = vim.fn.getcwd()
  end

  local note_path = vim.fs.joinpath(target_dir, filename)

  -- Never overwrite an existing note.
  if vim.uv.fs_stat(note_path) then
    vim.notify(
      "Note already exists: " .. note_path,
      vim.log.levels.WARN
    )
    return
  end

  local title = filename:gsub("%.md$", "")
  content = replace_placeholders(content, title)

  local success, err = pcall(function()
    local file = assert(io.open(note_path, "w"))
    file:write(content)
    file:close()
  end)

  if not success then
    vim.notify(
      "Could not create note: " .. tostring(err),
      vim.log.levels.ERROR
    )
    return
  end

  vim.cmd("edit " .. vim.fn.fnameescape(note_path))
end

function M.new_note(filename)
  local templates = get_templates()

  if #templates == 0 then
    vim.notify(
      "No Markdown templates found in " .. M.config.templates_dir,
      vim.log.levels.WARN
    )
    return
  end

  vim.ui.select(templates, {
    prompt = "Select a template:",
    format_item = function(item)
      return item:gsub("%.md$", "")
    end,
  }, function(choice)
    if choice then
      create_note(choice, filename)
    end
  end)
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", defaults, opts or {})

  vim.api.nvim_create_user_command("NewNote", function(args)
    M.new_note(args.args)
  end, {
    nargs = "?",
    desc = "Create a Markdown note from a template",
  })
end

return M
