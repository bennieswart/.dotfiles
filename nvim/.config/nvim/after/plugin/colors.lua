require("rose-pine").setup({
    disable_italics = true
})

vim.cmd.colorscheme("rose-pine")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.cmd("highligh BadWhitespace ctermbg=red guibg=darkred")
vim.cmd("au BufNewFile,BufRead *.lua match BadWhitespace /\\(\\s\\+$\\)\\|\\(\\t\\)/")
