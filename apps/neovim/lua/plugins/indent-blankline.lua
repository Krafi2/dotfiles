require("indent_blankline").setup {
    char = "▏",
    buftype_exclude = {
        "help",
        "terminal",
        "dashboard",
        "packer",
        "nofile",
    },
    filetype_exclude = {
        "packer",
        "NvimTree",
        "help",
        "OUTLINE",
        "norg",
    },
    use_treesitter = true,
    show_trailing_blankline_indent = false,
}

vim.wo.colorcolumn = "99999" -- Fix to a bug
