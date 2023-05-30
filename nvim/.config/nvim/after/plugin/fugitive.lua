-- Open git status.
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Open git blame.
vim.keymap.set("n", "<leader>gb", function() vim.cmd.Git("blame") end)
