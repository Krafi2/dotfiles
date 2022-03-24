local o, wo, bo, fn, opt = vim.o, vim.wo, vim.bo, vim.fn, vim.opt
local utils = require "utils"

-- Set some options for all filetypes because they might be overwritten by the parent window.
-- For example when opening files from the integrated terminal, `number` gets turned off.
utils.command("autocmd FileType * ", function()
    if bo.buftype ~= "" then
        return
    end
    -- Side column
    wo.signcolumn = "yes"
    wo.number = true -- Number lines
    wo.relativenumber = false -- Relative numbering
end)

-- Indentation
o.expandtab = true -- Expand tabs to spaces
o.tabstop = 4 -- Tab is 4 columns
o.softtabstop = 4 -- Tab is 4 columns
o.shiftwidth = 4 -- Indent 4 columns
o.smartindent = true

-- Title
o.title = true
o.titleold = fn.expand "$TERMINAL"
o.titlestring = "%<%F%="

-- Window adjustments
o.pumheight = 10 -- Makes popup menu smaller
o.cmdheight = 2 -- More space for displaying messages
o.splitbelow = true -- Horizontal splits will automatically be below
o.splitright = true -- Vertical splits will automatically be to the right
o.fillchars = "" -- stylua: ignore
    .. "stl: "
    .. ",stlnc: "
    .. ",msgsep:▔"
    .. ",vert:│"
    -- .. ",vert:▏"
    .. ",eob: "

-- Tabs
o.hidden = true -- Required to keep multiple buffers open
o.showtabline = 2 -- Always show tabs
o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 5

-- Persist state
o.undofile = true -- Save edit history

-- Misc
o.wrap = false -- Display long lines as just one line
o.cursorline = true -- Enable highlighting of the current line
o.mouse = "a" -- Enable mouse interaction
o.conceallevel = 2 -- So that we can see `` in markdown files
o.concealcursor = "nc"
o.termguicolors = true -- Enable true colour support
o.lazyredraw = true -- Don't update screen when processing macros
o.updatetime = 300 -- Faster completion
o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
o.synmaxcol = 1000 -- Do not highlight long lines
o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
o.guifont = "JetBrainsMono Nerd Font:h10"
o.showmode = false -- Show current mode
o.completeopt = "menuone,noselect"
o.inccommand = "split" -- Show a preview of editing operations
o.autoread = true
o.shell = "/bin/bash"
o.sessionoptions = "buffers,curdir,folds,help,winsize"
opt.iskeyword:append "-"
opt.shortmess:append "cI"
opt.whichwrap:append "<,>,[,]"
