local M = {}

local fn = vim.fn

-- Print message with error higlighting without stopping execution
function M.print_error(message)
    vim.api.nvim_echo({ { message, "ErrorMsg" } }, true, {})
end

local function make_loader(loader)
    return function(module)
        local success, result = pcall(loader, module)
        if success then
            return result
        else
            local info = debug.getinfo(2, "Sl")
            local loc_info = ("[%s:%d]"):format(
                info.short_src,
                info.currentline
            )
            local message = string.format(
                "Error while loading module '%s' at %s: %s",
                module,
                loc_info,
                result
            )
            M.print_error(message)
        end
    end
end

-- Try to require a module.
-- If the operation fails, print the error but don't stop execution.
M.try_require = make_loader(require)

-- Load a module even if it has been cached.
function M.reload(module)
    package.loaded[module] = nil
    return require(module)
end

-- Load a module even if it has been cached.
-- Prints any errors but doesn't panic.
M.try_reload = make_loader(M.reload)

-- Check if a module at this path exists
function M.module_exists(path)
    return fn.filereadable(path .. ".lua") == 1
        or fn.filereadable(path .. "/init.lua") == 1
end

-- Register a plugin with packer and load its config if possible.
-- The name of the config file is the plugin's name cut off at the first '.'
function M.plugin(opts)
    local use = require("packer").use
    local config_path = fn.stdpath "config"

    local segments = vim.split(opts[1], "/", true)
    local raw_name = segments[#segments]
    -- Match alphanumerics and "-" after last slash. Everything else is omitted.
    local name = raw_name:match "([%w%-_]+)"
    local config = "plugins/" .. name
    local setup = "plugins_pre/" .. name

    if
        not opts.config and M.module_exists(config_path .. "/lua/" .. config)
    then
        opts.config = ("require('utils').try_reload('%s')"):format(config)
    end

    if not opts.setup and M.module_exists(config_path .. "/lua/" .. setup) then
        local packadd = ("vim.api.nvim_command('packadd!%s')"):format(raw_name)
        local load = ("require('utils').try_reload('%s')"):format(setup)
        opts.setup = packadd .. ";" .. load
    end
    use(opts)
end

function M.print_caller()
    print(debug.getinfo(3).name)
end

function M.stack_trace()
    print(debug.traceback "Stack trace")
    print(debug.getinfo(1))
    print "Stack trace end"
end

-- The values of the guards are stored inside single-element tables,
-- so we can differentiate between a missing value and nil
local guards = {}

-- If there is no guard associated with `name`, create one and give it the value `val`.
-- `val` can be either a value or a function, in which case the rest of the variadic
-- parameters are passed to it and the return value is used instead.
function M.guard(name, val, ...)
    if not guards[name] then
        val = val or true
        if type(val) == "function" then
            guards[name] = { val(...) }
        else
            guards[name] = { val }
        end
    else
        return guards[name][1]
    end
end

local quotepattern = "([" .. ("%^$().[]*+-?"):gsub("(.)", "%%%1") .. "])"
-- Escape all speacial regex characters in a string
function M.escape_regex(str)
    return str:gsub(quotepattern, "%%%1")
end

local funcs = {}

function M.get_func(id)
    return funcs[id]
end

function M.command(event, func)
    local idx = #funcs + 1
    funcs[idx] = func
    vim.api.nvim_command(
        ("%s lua require('utils').get_func(%d)()"):format(event, idx)
    )
end

function M.colorscheme(name, palette)
    vim.g.colors_name = name

    local lush = require "lush"
    local lbase = require "lbase"

    for k, v in pairs(palette) do
        palette[k] = lush.hsl(v)
    end

    lbase.set_palette(palette)
    local spec = M.reload "lush_theme/lbase16"
    lush(spec)
end

function M.term_running(buf)
    local function get_opt(name)
        vim.api.nvim_buf_get_option(buf, name)
    end

    if get_opt "buftype" == "terminal" then
        local id = get_opt "channel"
        return vim.fn.jobwait({ id }, 0) == -1
    else
        return false
    end
end

return M
