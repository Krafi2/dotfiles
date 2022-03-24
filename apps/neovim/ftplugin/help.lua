require("which-key").register({
    ["q"] = { "<cmd>bdelete<cr>", "Close" },
    ["<CR>"] = { "<C-]>", "Jump to tag" },
    ["<BS>"] = { "<C-T>", "Go back" },
}, {
    buffer = 0,
})
