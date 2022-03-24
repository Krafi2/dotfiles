require("lsp/config").register_on_attach(
    function()
        require("lsp_signature").on_attach {
            bind = true,
            use_lspsaga = false,
            hint_prefix = "⬢ ",
            hint_enable = true,
            hint_scheme = "Function"
        }
    end
)
