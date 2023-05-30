local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")

local function buffer_save(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local entry = picker:get_selection()
    local selection = picker:get_selection_row()
    local window = vim.api.nvim_get_current_win()
    entry.indicator = entry.indicator:sub(1, 3) .. ' '

    vim.cmd("noautocmd sb" .. entry.bufnr)
    vim.cmd.x()
    vim.api.nvim_set_current_win(window)
    picker:refresh()
    vim.defer_fn(function()
        picker:set_selection(selection)
    end, 50)
end

local function buffer_delete(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    if picker.manager:num_results() <= 1 then
        return -- Cannot delete the last buffer
    end

    picker:delete_selection(function(entry)
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if buf == entry.bufnr then
                vim.api.nvim_win_call(win, vim.cmd.bp)
            end
        end
        vim.api.nvim_buf_delete(entry.bufnr, { force = true })
        -- TODO: prompt if unsaved
    end)
end

local function find_files()
    local opts = {}
    if vim.bo.filetype == "netrw" then
        opts.cwd = vim.b.netrw_curdir
    end
    return builtin.find_files(opts)
end

local function live_grep()
    local opts = {}
    if vim.bo.filetype == "netrw" then
        opts.cwd = vim.b.netrw_curdir
    end
    return builtin.live_grep(opts)
end

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-h>"] = "which_key",
            },
        },
        layout_config = {
            horizontal = { width = 0.9 },
        },
    },
    pickers = {
        buffers = {
            attach_mappings = function(_, map)
                map("n", "d", buffer_delete, {nowait = true, silent=true})
                map("n", "s", buffer_save, {nowait = true, silent=true})
                return true
            end,
        },
    },
})

vim.keymap.set("n", "<leader>pt", builtin.treesitter, {})
vim.keymap.set("n", "<leader>pf", find_files, {})
vim.keymap.set("n", "<leader>pg", live_grep, {})
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
