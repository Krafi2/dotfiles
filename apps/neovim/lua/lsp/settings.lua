vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = {
            -- prefix = "⚫" ,
            -- prefix = "",
            prefix = "𥉉",
            spacing = 2,
        },
        signs = true,
        update_in_insert = true,
        severity_sort = true,
        underline = true,
    }
)

local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " ",
}
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Autocomplete symbols
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "   (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)",
}

-- Format on save
require("lsp/config").register_on_attach(function(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    end
end)
