local function FugitiveBranch()
    local head = vim.fn.FugitiveHead()
    if head ~= '' then
        local changed = vim.fn.FugitiveExecute({"diff", "--quiet"}).exit_status ~= 0
        head = (changed and '+' or '*') .. head
    end
    return head
end
local branch = vim.fn.exists("*FugitiveHead") and FugitiveBranch or "branch"

require("lualine").setup({
    options = {
        icons_enabled = false,
    },
    sections = {
        lualine_b = {
            branch,
            "diff",
            "diagnostics",
        },
        lualine_c = {
            {
                "filename",
                path = 1,
            }
        },
    },
})
