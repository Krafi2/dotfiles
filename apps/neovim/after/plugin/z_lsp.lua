-- The lsp config has to be loaded last because some plugins may modify its configuration.
require("utils").try_reload "lsp"
