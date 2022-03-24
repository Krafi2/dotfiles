local neoscroll = require "neoscroll"
neoscroll.setup {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {
        "<C-u>",
        "<C-d>",
        -- "<C-b>",
        -- "<C-f>",
        -- "<C-y>",
        -- "<C-e>",
        -- "zt",
        -- "zz",
        -- "zb",
    },
    hide_cursor = true, -- Hide cursor while scrolling
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = "qudratic", -- Default easing function
    pre_hook = nil,
    post_hook = nil,
}

local speed = 200 -- Scrolling speed in lines per second

local function s_time(lines)
    return vim.fn.abs(lines / speed * 1000)
end

local function scroll(lines, move_cursor)
    return function()
        require("neoscroll").scroll(lines, move_cursor, s_time(lines))
    end
end

local function get_height()
    return vim.api.nvim_win_get_height(0)
end

local function z(func)
    return function()
        neoscroll[func](s_time(get_height() / 2))
    end
end

local mapping = {
    ["<C-u>"] = { scroll(-20, true), "Scroll up" },
    ["<C-d>"] = { scroll(20, true), "Scroll down" },
    ["zz"] = { z "zz", "Center cursor" },
    ["zt"] = { z "zt", "Move cursor to top" },
    ["zb"] = { z "zb", "Move cursor to bottom" },
}
require("which-key").register(mapping, { mode = "n" })
require("which-key").register(mapping, { mode = "v" })
