-- Open netrw directory listing.
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Save current cursor position in jump list whenever moving more than 2 lines up/down.
-- Otherwise, treat long lines as break lines.
local function jumpmove(key) return string.format([[v:count ? (v:count >= 3 ? "m'" . v:count : "") . "%s" : "g%s"]], key, key) end
vim.keymap.set({"n", "v"}, "j", jumpmove("j"), { noremap = true, expr = true })
vim.keymap.set({"n", "v"}, "k", jumpmove("k"), { noremap = true, expr = true })

-- Move the selected lines up/down.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Retain cursor position with J.
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in middle of screen with C-d/C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep cursor in middle of screen with search next/previous.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste/delete without changing buffer contents.
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Yank to system clipboard.
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Disable Q.
vim.keymap.set("n", "Q", "<nop>")
