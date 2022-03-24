require("gitsigns").setup {
    -- signs = {
    --     add          = {hl = "GitSignsAdd"   , text = "⏐"},
    --     change       = {hl = "GitSignsChange", text = "⏐"},
    --     delete       = {hl = "GitSignsDelete", text = "⏐"},
    --     topdelete    = {hl = "GitSignsDelete", text = "⏐"},
    --     changedelete = {hl = "GitSignsChange", text = "⏐"},
    -- },
    update_debounce = 200,
    keymaps = {}
}

-- -- Set gitsign colors
-- require("nbase16").highlight {
--     GitSignsAdd    = {guifg = "base0B", gui = "bold"},
--     GitSignsChange = {guifg = "base0E", gui = "bold"},
--     GitSignsDelete = {guifg = "base08", gui = "bold"},
-- }
