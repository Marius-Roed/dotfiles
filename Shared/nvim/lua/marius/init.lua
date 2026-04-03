vim.opt.termguicolors = true

-- PLUGINS ADDED WITH vim.pack
vim.pack.add({
    'https://github.com/EdenEast/nightfox.nvim', -- Colorscheme
    { -- Treesitter
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },
    {
        src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        branch = "harpoon2",
    },
    -- Language Server Protocol
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    {
        src = "https://github.com/Saghen/blink.cmp",
        branch = "v1",
        build = "cargo build --release",
    },
    "https://github.com/stevearc/conform.nvim",
})

vim.cmd.colorscheme("carbonfox")

-- require("marius.remap")
require("marius.set")
require("marius.plugins")
require("marius.autocmd") -- Pulls in statusline and remaps
