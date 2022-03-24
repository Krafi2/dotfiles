return function(server)
    local utils = require "utils"
    local config = require "lsp/config"

    server:setup {
        cmd = server:get_default_options().cmd,
        on_attach = config.on_attach,
        capabilities = config.make_capabilities(),
        on_new_config = function(config, root_dir)
            -- Use the lua-dev config when the root_dir path contains "nvim"
            if string.find(root_dir, "nvim", nil, true) then
                local luadev = require("lua-dev").setup {}
                config.settings = luadev.settings
            end
            -- sumneko_lua doesn't show diagnostics inside library files,
            -- which is annoying when you want to edit them. To fix this,
            -- we remove the library when we're in its root directory, as
            -- completions will be included anyway.
            local library = config.settings.Lua.workspace.library
            local match = utils.escape_regex(root_dir)
            for dir, _ in pairs(library) do
                if dir:match(match) then
                    library[dir] = nil
                end
            end

            -- not sure if this is needed
            local path = config.settings.Lua.runtime.path
            for _, v in ipairs { "?.lua", "?/init.lua", "?/?.lua" } do
                if not vim.tbl_contains(path, v) then
                    table.insert(path, v)
                end
            end
        end,
    }
end
