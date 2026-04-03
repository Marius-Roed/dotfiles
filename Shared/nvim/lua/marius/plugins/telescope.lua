require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
    },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope search word under cursor" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>sq", function()
    builtin.lsp_document_symbols({
        symbols = { 'function', 'method' }
    })
end, { desc = "Show functions for current buffer in telescope" })
