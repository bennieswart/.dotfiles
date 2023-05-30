-- Automatically install packer if it is not yet installed.
local function ensure_packer()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        print(
            "********************************************************************************\n" ..
            "Installing packer - plugin config will likely fail.\n" ..
            "Wait for installation to complete and then restart neovim\n" ..
            "********************************************************************************\n"
        )
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd("packadd packer.nvim")
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = {
            {"nvim-lua/plenary.nvim"},
        }
    })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
    })

    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use("nvim-treesitter/playground")

    use("theprimeagen/harpoon")

    use("mbbill/undotree")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},
            {
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            {"williamboman/mason-lspconfig.nvim"},

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},

            -- Formatting
            {"mhartington/formatter.nvim"}
        }
    })

    use("lukas-reineke/indent-blankline.nvim")

    use("instant-markdown/vim-instant-markdown")

    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            {"nvim-tree/nvim-web-devicons", opt = true},
        },
    })

    use("ggandor/leap.nvim")

    use("tpope/vim-dispatch")
    use("tpope/vim-fugitive")
    use("tpope/vim-surround")
    use("tpope/vim-speeddating")
    use("tpope/vim-repeat")

    use("christoomey/vim-tmux-navigator")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
