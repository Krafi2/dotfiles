vim.g.bufferline = {
    animation = true,
    auto_hide = true,
    tab_pages = false,

    icons = true,
    icon_separator_active = " ",
    icon_separator_inactive = " ",
    icon_close_tab = "",
    icon_close_tab_modified = "●",

    maximum_padding = 4,
    maximum_length = 30,

    semantic_letters = true,
    no_name_title = "[None]",
}

-- Barbar will stay hidden unless we do this on startup
vim.api.nvim_command "autocmd VimEnter * BarbarEnable"
