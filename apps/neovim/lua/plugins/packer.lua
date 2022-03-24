local function configure()
    require("packer").init {
        -- By default, packer loads plugin config before the plugins themeselves,
        -- which leads to some unexpected behaviour
        compile_path = vim.fn.stdpath "config"
            .. "/packer/start/packer/plugin/packer_compiled.lua",
        display = {
            -- header_sym = "─",
            header_sym = "▔",
        },
    }

    -- Reload plugins when the plugin configuration changes
    vim.api.nvim_command "command ReloadConfig lua require('plugins/packer').reload()"
end

-- Install packer if not available
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local installed = true

if fn.empty(fn.glob(install_path)) > 0 then
    installed = false
    local cmd = ([[
        !git clone --depth 1 'https://github.com/wbthomason/packer.nvim' '%s' 
        packadd packer.nvim
    ]]):format(install_path)
    vim.cmd(cmd)
    configure()
    vim.cmd "PackerInstall"
else
    configure()
end

-- Add the packer directory as the last entry in packpath
if not require("utils").guard "packer" then
    local packer_dir = fn.stdpath "config" .. "/packer"
    local packpath = fn.split(vim.o.packpath, ",")
    for i, path in ipairs(packpath) do
        -- Insert the path before the first directory ending in after
        if path:match "after$" then
            table.insert(packpath, i, packer_dir)
            break
        end
    end
    vim.o.packpath = table.concat(packpath, ",")
end

if not installed then
    vim.api.nvim_command "PackerInstall"
end

local M = {}

function M.reload()
    local packer = require "packer"
    packer.reset()
    require("utils").try_reload "plugins"
    packer.install()
    packer.clean()
    packer.compile()
end

-- Using an autocommand breaks a few highlights for some unfanthomable reason, so manual reloading it is
-- vim.api.nvim_command "augroup PackerCustom"
-- vim.api.nvim_command "autocmd!"
-- vim.api.nvim_command "autocmd BufWritePost plugins.lua ReloadConfig"
-- vim.api.nvim_command "augroup END"

return M
