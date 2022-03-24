local utils = require "utils"
require("bufferline").setup {
    options = {
        numbers = "none",
        indicator_icon = "",
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = { "a", "b" },
        enforce_regular_tabs = false,
        view = "multiwindow",
        mappings = "true",
    },
}
