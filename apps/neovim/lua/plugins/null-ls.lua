local null_ls = require "null-ls"
local config = require "lsp/config"

-- Defer null-ls setup to when the lsp is ready
config.register_on_init(function()
    null_ls.setup {
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.markdownlint,
            null_ls.builtins.formatting.prettierd,
        },
        on_attach = config.on_attach,
    }
end)
