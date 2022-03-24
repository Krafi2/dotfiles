local M = {}

local attach_funcs = {}

-- Register a callback which will be ran when a language server attaches to a buffer.
-- @param func Callback function
function M.register_on_attach(func)
    table.insert(attach_funcs, func)
end

-- Call all registered callbacks
function M.on_attach(client, buffer)
    for _, func in ipairs(attach_funcs) do
        func(client, buffer)
    end
end

local init_funcs = {}

-- Register a callback which will be ran when a language server attaches to a buffer.
-- @param func Callback function
function M.register_on_init(func)
    table.insert(init_funcs, func)
end

-- Call all registered callbacks
function M.on_init()
    for _, func in ipairs(init_funcs) do
        func()
    end
end

local capability_funcs = {}

function M.register_capabilities(func)
    table.insert(capability_funcs, func)
end

function M.make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    for _, func in ipairs(capability_funcs) do
        capabilities = func(capabilities)
    end
    return capabilities
end

return M
