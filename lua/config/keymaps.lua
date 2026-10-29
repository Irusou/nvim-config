local map = vim.keymap.set

map("n", "j", "gj", { silent = true, nowait = true })
map("n", "k", "gk", { silent = true, nowait = true })
map("i", "jj", "<Esc>", { silent = true, nowait = true })
map("i", "jk", "<Esc>", { silent = true, nowait = true })
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gy", vim.lsp.buf.type_definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>\\", "<cmd>ToggleTerm<cr>")
map("t", "<leader>\\", [[<C-\><C-n><cmd>ToggleTerm<cr>]])
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
map('n', '<leader>fe', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus nvim-tree' })

vim.g.user_emmet_expandabbr_key = "<Tab>"

-- move to start/end of line
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$")

-- insert comments
map("n", "<C-_>", "gcc", { remap = true })
map("v", "<C-_>", "gc", { remap = true })
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })

-- theme switcher keymaps
local switcher = require("config.theme_switcher")
map("n", "<leader>tn", switcher.next_theme, { desc = "Next theme" })
map("n", "<leader>tp", switcher.prev_theme, { desc = "Prev theme" })
map("n", "<leader>tt", switcher.pick_theme, { desc = "Pick theme" })
map("n", "<leader>tb", switcher.toggle_transparency, { desc = "Toggle transparency" })

-- tabs
map("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><tab>c", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<leader><tab>f", "<cmd>tabnew %<CR>", { desc = "Current buffer in new tab" })
map("n", "<leader><tab>l", "<cmd>tabmove +1<CR>", { desc = "Move tab right" })
map("n", "<leader><tab>h", "<cmd>tabmove -1<CR>", { desc = "Move tab left" })

-- Cycle tabs (Alt+h/l, since H/L are taken)
map("n", "<A-l>", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<A-h>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Jump to tab by number (Alt+1..9)
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", i .. "gt", { desc = "Go to tab " .. i })
end

-- buffers
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
map("n", "<leader><leader>", "<C-^>", { desc = "Toggle last buffer" })

-- splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sm", "<cmd>only<CR>", { desc = "Maximize (close others)" })
map("n", "<leader>st", "<C-w>T", { desc = "Move split to new tab" })
map("n", "<leader>sr", "<C-w>r", { desc = "Rotate splits" })

-- Navigate splits (also works out of terminal mode, which suits ToggleTerm)
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })

-- Resize splits
map("n", "<C-Up>", "<cmd>resize +2<CR>", { silent = true })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { silent = true })
map("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { silent = true })
map("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { silent = true })
