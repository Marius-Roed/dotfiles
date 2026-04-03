local function pack_add(plugin_name)
    local bang = vim.v.vim_did_init == 0 and "!" or ""
    vim.cmd("packadd" .. bang .. " " .. plugin_name)
end

pack_add("nvim-treesitter")
require("marius.plugins.treesitter")

pack_add("mason.nvim")
require("marius.plugins.mason")

pack_add("nvim-lspconfig")
pack_add("blink.cmp")
require("marius.plugins.blink")
pack_add("conform.nvim")
require("conform")

pack_add("telescope.nvim")
require("marius.plugins.telescope")

pack_add("harpoon")
require("marius.plugins.harpoon")
