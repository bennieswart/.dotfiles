local push = function(args)
    local cmd = "push " .. (args or "")
    if vim.fn.exists(":Dispatch") then
        vim.cmd.Dispatch("git " .. cmd)
    else
        vim.cmd.Git(cmd)
    end
    vim.cmd("echo 'Pushing ...'")
end

-- Git push asynchronously.
vim.keymap.set("n", "<leader>gp", function() push() end, { buffer = true })
vim.keymap.set("n", "<leader>gpl", function() push("--force-with-lease") end, { buffer = true })
vim.keymap.set("n", "<leader>gpf", function() push("--force") end, { buffer = true })

-- Close fugitive window by just pressing 'q'.
vim.keymap.set("n", "q", ":q<cr>", { buffer = true })
