local FUNCS = { }

local function is_netrw()
    return vim.bo.filetype == "netrw"
end

-- Git branch function with caching and NF icons
local cached_branch = ""
local last_check = 0
local function git_branch()
    local now = vim.loop.now()
    if now - last_check > 5000 then
        cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
        last_check = now
    end
    if cached_branch ~= "" then
        return " \u{e725} " .. cached_branch .. " "
    end
    return ""
end

local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand("%"))
    if size < 0 then
        return ""
    end
    local size_str
    if size < 1024 then
        size_str = size .. "B"
    elseif size < 1024 * 1024 then
        size_str = string.format("%.1fK", size / 1024)
    else
        size_str = string.format("%.1fM", size / 1024 / 1024)
    end
    return " \u{f016} " .. size_str .. " "
end

local function mode_icon()
    if is_netrw() then
        return ""
    end
    local mode = vim.fn.mode()
    local modes = {
        n       = "NORMAL",
        i       = "INSERT",
        v       = "VISUAL",
        V       = "V-LINE",
        ["\22"] = "V-BLOCK",
        c       = "COMMAND",
        s       = "SELECT",
        S       = "S-LINE",
        ["\19"] = "S-BLOCK",
        r       = "REPLACE",
        R       = "REPLACE",
        ["!"]   = "SHELL",
        t       = "TERMINAL",
    }
    return modes[mode] or ( " " .. mode)
end

local mode_hl_map = {
    n = "ModeNormal",  no = "ModeNormal",
    i = "ModeInsert",  ic = "ModeInsert",
    v = "ModeVisual",  V = "ModeVisual", ["\22"] = "ModeVisual",
    R = "ModeReplace", Rc = "ModeReplace",
    c = "ModeCommand", cv = "ModeCommand",
    t = "ModeTerm"
}
local function mode_highlight()
    local mode = vim.api.nvim_get_mode().mode
    return mode_hl_map[mode] or "ModeNormal"
end

local function get_hl_attr(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    return hl[attr]
end

local function sep_tri()
    return is_netrw() and "" or "\u{e0b0}"
end

local startup_cwd = vim.fn.getcwd()
local function relative_path()
    local full = vim.fn.expand("%:p")
    local base = vim.fn.fnamemodify(startup_cwd, ":h") .. "/"
    if full:sub(1, #base) == base then
        return full:sub(#base + 1)
    end
    return full
end

_G.mode_icon = mode_icon
_G.mode_highlight = function() return is_netrw() and "" or "%#" .. mode_highlight() .. "#" end
_G.mode_sep_hl = function() return is_netrw() and "" or "%#" .. mode_highlight() .. "Sep#" end
_G.sep_tri = sep_tri
_G.git_branch = git_branch
_G.file_size = file_size
_G.relative_path = relative_path

vim.cmd([[
    highlight StatusLineBold gui=bold cterm=bold
]])

function FUNCS.setup_mode_highlights()
    local sl_bg = get_hl_attr("StatusLine", "bg")

    -- bg pulled from colorscheme fg of relevant groups
    local modes = {
        { name = "ModeNormal",  src = "Function" },
        { name = "ModeInsert",  src = "String" },
        { name = "ModeVisual",  src = "Special" },
        { name = "ModeReplace", src = "DiagnosticError" },
        { name = "ModeCommand", src = "Statement" },
        { name = "ModeTerm",    src = "Keyword" },
    }

    for _, m in ipairs(modes) do
        local bg = get_hl_attr(m.src, "fg")
        if bg then
            --Determine if bg is light or dark for contrast text
            local r = bit.rshift(bit.band(bg, 0xFF0000), 16)
            local g = bit.rshift(bit.band(bg, 0x00FF00), 8)
            local b = bit.band(bg, 0x0000FF)
            local luminance = (0.299 * r * 0.587 * g + 0.114 * b)
            local fg = luminance > 128 and 0x000000 or 0xffffff

            vim.api.nvim_set_hl(0, m.name, { fg = fg, bg = bg, bold = true })
            vim.api.nvim_set_hl(0, m.name .. "Sep", { fg = bg, bg = sl_bg })
        end
    end
end

local function setup_dynamic_status()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        callback = function()
            vim.opt_local.statusline = table.concat({
                "%{%v:lua.mode_highlight()%} ",
                "%{v:lua.mode_icon()}",
                " %{%v:lua.mode_sep_hl()%}",
                "%{%v:lua.sep_tri()%}",
                "%#StatusLine#",
                " %{v:lua.relative_path()} %h%m%r",
                "%{v:lua.git_branch()}",
                " %{v:lua.file_size()}",
                "%=", -- align right from here
                " %l:%c %P"
            })
        end,
    })
    vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
        callback = function()
            vim.opt_local.statusline = " %f %h%m%r %= %l:%c %P"
        end,
    })
end

FUNCS.setup_mode_highlights()
setup_dynamic_status()

return FUNCS
