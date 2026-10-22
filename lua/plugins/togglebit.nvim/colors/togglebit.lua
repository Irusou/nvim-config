vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "togglebit"

local c = {
  bg       = "#1f2430",
  bg_dark  = "#181c23",
  bg_float = "#000000",
  bg_sel   = "#33415e",
  bg_line  = "#232a38",
  fg       = "#ccccc5",
  fg_dim   = "#71757a",
  comment  = "#7f9d99",
  keyword  = "#e6c58a", -- pub, fn, let, match, impl
  func     = "#a8e5d0", -- function names (bold)
  type     = "#73c7e8", -- types / paths
  trait    = "#8fe0a8", -- Into, &, traits
  self_    = "#b4a8e0", -- self, fields
  string   = "#b8cc73",
  number   = "#e6b673",
  red      = "#f1887b",
  yellow   = "#e6c58a",
  green    = "#8fe0a8",
  blue     = "#73c7e8",
  cursor   = "#ffb454",
}

local function hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- UI
hl("Normal", { fg = c.fg, bg = c.bg })
hl("Cursor", { fg = c.bg, bg = c.cursor })
hl("CursorLine", { bg = c.bg_line })
hl("CursorLineNr", { fg = c.keyword })
hl("LineNr", { fg = c.fg_dim })
hl("NormalFloat", { fg = c.fg, bg = c.bg_dark })
hl("FloatBorder", { fg = c.fg_dim, bg = c.bg_dark })
hl("MsgArea", { fg = c.fg, bg = c.bg })
hl("SignColumn", { bg = c.bg })
hl("Visual", { bg = c.bg_sel })
hl("Search", { fg = c.bg, bg = c.yellow })
hl("IncSearch", { fg = c.bg, bg = c.cursor })
hl("MatchParen", { fg = c.cursor, bold = true })
hl("StatusLine", { fg = c.fg, bg = c.bg_dark })
hl("StatusLineNC", { fg = c.fg_dim, bg = c.bg_dark })
hl("WinSeparator", { fg = c.bg_dark })
hl("Pmenu", { fg = c.fg, bg = c.bg_dark })
hl("PmenuSel", { fg = c.bg, bg = c.func })
hl("ErrorMsg", { fg = c.bg, bg = c.red })
hl("Directory", { fg = c.type })
hl("NonText", { fg = c.fg_dim })

-- Syntax
hl("Comment", { fg = c.comment })
hl("Constant", { fg = c.number })
hl("String", { fg = c.string })
hl("Number", { fg = c.number })
hl("Boolean", { fg = c.number })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.func, bold = true })
hl("Statement", { fg = c.keyword })
hl("Keyword", { fg = c.keyword })
hl("Operator", { fg = c.fg })
hl("PreProc", { fg = c.keyword })
hl("Type", { fg = c.type })
hl("Special", { fg = c.trait })
hl("Delimiter", { fg = c.keyword })
hl("Todo", { fg = c.bg, bg = c.yellow })

-- Tree-sitter
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.self_ })
hl("@variable.member", { fg = c.self_ })
hl("@property", { fg = c.self_ })
hl("@function", { link = "Function" })
hl("@function.call", { link = "Function" })
hl("@function.method", { link = "Function" })
hl("@function.method.call", { link = "Function" })
hl("@function.macro", { fg = c.func, bold = true })
hl("@keyword", { fg = c.keyword })
hl("@type", { fg = c.type })
hl("@type.builtin", { fg = c.type })
hl("@module", { fg = c.type })
hl("@lsp.type.interface", { fg = c.trait })
hl("@lsp.type.lifetime", { fg = c.yellow })
hl("@punctuation.bracket", { fg = c.keyword })
hl("@punctuation.delimiter", { fg = c.fg })

-- Diagnostics
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.green })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })

-- lualine theme, registered in memory (no extra file or folder needed)
package.preload["lualine.themes.togglebit"] = function()
  local function mode(color)
    return {
      a = { fg = c.bg, bg = color, gui = "bold" },
      b = { fg = c.fg, bg = c.bg_dark },
      c = { fg = c.fg_dim, bg = c.bg },
    }
  end
  return {
    normal = mode(c.func),
    insert = mode(c.type),
    visual = mode(c.self_),
    replace = mode(c.red),
    command = mode(c.keyword),
    inactive = {
      a = { fg = c.fg_dim, bg = c.bg_dark },
      b = { fg = c.fg_dim, bg = c.bg_dark },
      c = { fg = c.fg_dim, bg = c.bg },
    },
  }
end

-- lualine theme, registered in memory (no extra file or folder needed)
package.preload["lualine.themes.togglebit"] = function()
  local function mode(color)
    return {
      a = { fg = c.bg, bg = color, gui = "bold" },
      b = { fg = c.fg, bg = c.bg_dark },
      c = { fg = c.fg_dim, bg = c.bg },
    }
  end
  return {
    normal = mode(c.func),
    insert = mode(c.type),
    visual = mode(c.self_),
    replace = mode(c.red),
    command = mode(c.keyword),
    inactive = {
      a = { fg = c.fg_dim, bg = c.bg_dark },
      b = { fg = c.fg_dim, bg = c.bg_dark },
      c = { fg = c.fg_dim, bg = c.bg },
    },
  }
end
