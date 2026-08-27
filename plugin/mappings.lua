local default_opts = { noremap = true, silent = true }

--- @type function
local map = vim.keymap.set

map("n", "<Esc>", ":nohlsearch<CR>", default_opts)

map("n", "<C-p>", "<Plug>(nvim-dir-up)")

map("n", "<M-h>", "<<")
map("n", "<M-j>", ":m .+1<CR>==")
map("n", "<M-k>", ":m .-2<CR>==")
map("n", "<M-l>", ">>")

map("i", "<M-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<M-k>", "<Esc>:m .-2<CR>==gi")

map("v", "<M-h>", "<gv")
map("v", "<M-j>", ":m '>+1<CR>gv=gv")
map("v", "<M-k>", ":m '<-2<CR>gv=gv")
map("v", "<M-l>", ">gv")

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("c", "<C-h>", "<Left>", { desc = "move left by char in command mode" })
map("c", "<C-l>", "<Right>", { desc = "move right by char in command mode" })
map("c", "<M-h>", "<S-Left>", { desc = "move left by word in command mode" })
map("c", "<M-l>", "<S-Right>", { desc = "move right by word in command mode" })
