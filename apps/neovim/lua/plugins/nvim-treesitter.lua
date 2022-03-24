require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "rust", "python", "toml" },
    highlight = { enable = true, disable = {} },
    indent = { enable = true },
    fold = { enable = true },
    -- Enable the treesitter-textsubjets module, which provides AST-based selection
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
        },
    },
}
