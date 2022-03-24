local utils = require "utils"
local fn = vim.fn

utils.command("command! OpenUrl", function()
    local word = fn.expand "<cWORD>"
    local pattern =
        "(https?://(([%w_.~!*:@&+$/?%%#-]-)(%w[-.%w]*%.)(%w+)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*)))"
    local match = word:match(pattern)
    if match then
        print("Opening " .. match)
        vim.api.nvim_command(([[silent !xdg-open "%s"]]):format(match))
    else
        print "No url found"
    end
end)

utils.command("command! GetHi", function()
    local line, col = fn.line ".", fn.col "."
    local synstack = fn.synstack(line, col)

    if #synstack == 0 then
        print "No highlight groups under cursor"
    end

    for _, group in ipairs(synstack) do
        local name = fn.synIDattr(group, "name")
        local link = fn.synIDattr(fn.synIDtrans(group), "name")
        if name == link then
            print(name)
        else
            print(("%s -> %s"):format(name, link))
        end
    end
end)

utils.command("command! CloseInactiveTerminals ", function()
    local buffers = fn.getbufinfo()
    for _, buf in ipairs(buffers) do
        buf = buf.bunr
        if
            vim.api.nvim_buf_get_option(buf, "buftype")
                == "terminal"
            and not utils.term_running(buf)
        then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end)
