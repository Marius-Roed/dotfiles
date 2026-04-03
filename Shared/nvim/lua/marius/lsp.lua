local FUNCS = { }
local remaps = require("marius.remap")

local diagnostic_signs = {
    Error = "! ",
    Warn = "! ",
    Hint = "? ",
    Info = "? ",
}

vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 4 },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
            [vim.diagnostic.severity.WARN]  = diagnostic_signs.Warn,
            [vim.diagnostic.severity.HINT]  = diagnostic_signs.Hint,
            [vim.diagnostic.severity.INFO]  = diagnostic_signs.Info,
        },
    },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        focusable = false,
        style = "minimal",
    },
})

do
    local orig = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig(contents, syntax, opts, ...)
    end
end

function FUNCS.lsp_attach(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
        return
    end

    local bufnr = ev.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    remaps.remap_lsp(opts)

    if client:supports_method("textDocument/codeAction", bufnr) then
        remaps.client_remaps(bufnr, opts)
    end
end

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})
vim.lsp.config("intelephense", {
    settings = {
        intelephense = {
            stubs = {
                "apache", "bcmath", "bz2", "calendar", "com_dotnet",
                "Core", "ctype", "curl", "date", "dba", "dom",
                "enchant", "exif", "FFI", "fileinfo", "filter",
                "fpm", "ftp", "gd", "gettext", "gmp", "hash",
                "iconv", "imap", "intl", "json", "ldap", "libxml",
                "mbstring", "meta", "mysqli", "oci8", "odbc",
                "openssl", "pcntl", "pcre", "PDO", "pdo_ibm",
                "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
                "Phar", "posix", "pspell", "readline", "Reflection",
                "session", "shmop", "SimpleXML", "snmp", "soap",
                "sockets", "sodium", "SPL", "sqlite3", "standard",
                "superglobals", "sysvmsg", "sysvsem", "sysvshm",
                "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc",
                "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
                "wordpress",
            },
            environment = {
                includePaths = {
                    vim.fn.expand("~/.config/composer/vendor/php-stubs/woocommerce-stubs"),
                }
            },
        }
    },
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

vim.lsp.enable({
    "lua_ls",
    "intelephense",
    "pyright",
    "bashls",
    "ts_ls",
    "gopls",
    "clangd",
})

return FUNCS
