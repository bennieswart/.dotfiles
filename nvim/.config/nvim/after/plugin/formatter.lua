require("formatter").setup({
    filetype = {
        python = {
            require("formatter.filetypes.python").black,
        },
        typescript = {
            require("formatter.filetypes.typescript").prettier,
        },
        typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
        },

        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})

vim.keymap.set("n", "<leader>fa", vim.cmd.FormatLock)

local FormatAutogroup = vim.api.nvim_create_augroup("FormatAutogroup", {clear = true})
vim.api.nvim_create_autocmd("User", {
    pattern = "FormatterPre",
    group = FormatAutogroup,
    callback = function()
        vim.cmd(":unsilent echo 'Formatting ...'")
    end,
})
vim.api.nvim_create_autocmd("User", {
    pattern = "FormatterPost",
    group = FormatAutogroup,
    callback = function()
        vim.cmd(":unsilent echo 'Formatting complete'")
    end,
})
