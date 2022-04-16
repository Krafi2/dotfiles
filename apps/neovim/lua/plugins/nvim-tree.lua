local tree = require "nvim-tree"
local bufferline = require "bufferline.state"
local utils = require "utils"

tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hide_dotfiles = 0,
    git = {
        ignore = false,
    },
    renderer = {
        nvim_tree_indent_markers = {
            enable = true,
        },
    }
}

local function is_tree(bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    return filetype == "NvimTree"
end

local cmd = vim.api.nvim_command

cmd "augroup NvimTreeTabline"
cmd "autocmd!"

utils.command("autocmd BufWinEnter * ", function()
    local buf = vim.fn.expand "<abuf>"
    if is_tree(buf) then
        -- Add one to the offset to account fot VertSplit
        bufferline.set_offset(vim.g.nvim_tree_width + 1)
    end
end)

utils.command("autocmd WinClosed * ", function()
    local buf = vim.fn.expand "<abuf>"
    if is_tree(buf) then
        bufferline.set_offset(0)
    end
end)

cmd "augroup END"
