-- This file is loaded by "after/plugin/lsp.lua" because some configuration
-- may be modified by plugins
local utils = require "utils"
local lsp_installer = require "nvim-lsp-installer"

require "lsp/settings"

lsp_installer.on_server_ready(function(server)
    local name = server.name
    local config = ("lsp/servers/%s"):format(name)
    local config_path = ("%s/lua/%s"):format(vim.fn.stdpath "config", config)

    -- Load config if available
    if utils.module_exists(config_path) then
        local init = utils.try_require(config)
        if type(init) == "function" then
            init(server)
        else
            utils.print_error(
                ("Lsp server '%s' didn't return an init function"):format(name)
            )
        end
    else -- Otherwise init with default configuration
        local config = require "lsp/config"
        server:setup {
            capabilities = config.make_capabilities(),
            on_attach = config.on_attach,
        }
    end

    server:attach_buffers()
end)

-- Initialize servers that have been registerd externally
require("lsp/config").on_init()
