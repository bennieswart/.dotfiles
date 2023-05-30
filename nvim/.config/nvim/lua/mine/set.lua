-- Use the default fat cursor in all modes.
vim.opt.guicursor = ""

-- Enable line numbers and relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Fix tabs.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Auto-indent new lines.
vim.opt.smartindent = true

-- Don't use swap files and don't backup files on save.
vim.opt.swapfile = false
vim.opt.backup = false

-- Persist undo state to disk.
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Incremental search.
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 200
vim.opt.colorcolumn = "120"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hidden = true

vim.g.mapleader = " "
