local lsp = require("marius.lsp")
local highlights = require("marius.status")

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save ( Only when emf is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Return cursor to last known position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Restore last cursor position",
    callback = function()
        if vim.o.diff then -- Do not restore on diff
            return
        end

        local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
        local last_line = vim.api.nvim_buf_line_count(0)

        local row = last_pos[1]
        if row < 1 or row > last_line then
            return
        end

        pcall(vim.api.nvim_wind_set_cursor, 0, last_pos)
    end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "TelescopePrompt", "TelescopeResults", "TelescopePreview" },
    callback = function()
        vim.opt_local.statusline = ""
    end
})

-- Re-apply status highlight on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = highlights.setup_mode_highlights,
})

-- Force statusline redraw on mode change
vim.api.nvim_create_autocmd("ModeChanged", {
    group = augroup,
    callback = function() vim.cmd.redrawstatus() end,
})

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp.lsp_attach })
