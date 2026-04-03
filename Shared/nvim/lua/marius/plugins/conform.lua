require("conform").setup({
    formatters_by_ft = {
        -- Web stuff
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        html            = { "prettier" },
        css             = { "prettier" },
        svelte          = { "prettier" },

        -- PHP (WordPress standard)
        php = { "phpcbf" },

        -- Others
        c       = { "clang_format" },
        go      = { "goimports" },
        lua     = { "stylua" },
        python  = { "ruff_format" },
    },
    formatters = {
        phpcbf = {
            args = { "--standard=WordPress", "$FILENAME" }
        },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
