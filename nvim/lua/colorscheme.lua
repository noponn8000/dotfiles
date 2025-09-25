-- lua/colors/monokai.lua
local palette = {
    base1 = '#121212',
    base2 = '#26292C',
    base3 = '#2E323C',
    base4 = '#333842',
    base5 = '#4d5154',
    base6 = '#9ca0a4',
    base7 = '#b1b1b1',
    border = '#a1b5b1',
    brown = '#504945',
    white = '#f8f8f0',
    grey = '#8F908A',
    black = '#000000',
    pink = '#f92672',
    green = '#a6e22e',
    aqua = '#66d9ef',
    yellow = '#e6db74',
    orange = '#fd971f',
    purple = '#ae81ff',
    red = '#e95678',
    diff_add = '#3d5213',
    diff_remove = '#4a0f23',
    diff_change = '#27406b',
    diff_text = '#23324d',
}

-- Helper for setting highlights
local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Basic UI
hl("Normal",        { fg = palette.white, bg = palette.base1 })
hl("NormalNC",      { fg = palette.white, bg = palette.base2 })
hl("Comment",       { fg = palette.grey, italic = true })
hl("Visual",        { bg = palette.base3 })
hl("CursorLine",    { bg = palette.base2 })
hl("CursorColumn",  { bg = palette.base2 })
hl("LineNr",        { fg = palette.base5 })
hl("CursorLineNr",  { fg = palette.yellow, bold = true })
hl("VertSplit",     { fg = palette.border })

-- Syntax
hl("String",        { fg = palette.green })
hl("Function",      { fg = palette.aqua })
hl("Keyword",       { fg = palette.pink, bold = true })
hl("Identifier",    { fg = palette.white })
hl("Type",          { fg = palette.orange })
hl("Constant",      { fg = palette.purple })
hl("Number",        { fg = palette.purple })
hl("Boolean",       { fg = palette.purple })

-- Diagnostics
hl("DiagnosticError", { fg = palette.red })
hl("DiagnosticWarn",  { fg = palette.yellow })
hl("DiagnosticInfo",  { fg = palette.aqua })
hl("DiagnosticHint",  { fg = palette.green })

-- Diffs
hl("DiffAdd",    { bg = palette.diff_add })
hl("DiffDelete", { bg = palette.diff_remove })
hl("DiffChange", { bg = palette.diff_change })
hl("DiffText",   { bg = palette.diff_text })

