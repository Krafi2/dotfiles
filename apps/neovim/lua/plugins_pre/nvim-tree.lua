local g = vim.g
g.nvim_tree_side = "left"
g.nvim_tree_width = 30
g.nvim_tree_auto_ignore_ft = { "dashboard" } -- don't open tree on specific filetypes.
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_allow_resize = 1
g.nvim_tree_add_trailing = 1 -- append a trailing slash to folder names
g.nvim_tree_icon_padding = " "

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
}
g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        -- unstaged = "✗",
        -- staged = "✓",
        -- unmerged = "",
        -- renamed = "➜",
        -- untracked = "★",
        -- deleted = "",
        -- ignored = "◌",
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "",
        untracked = "",
        deleted = "",
        ignored = "",
    },
    folder = {
        -- disable indent_markers option to get arrows working or if you want both
        -- arrows and indent then just add the arrow icons in front of the default
        -- and opened folders below!
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
}
