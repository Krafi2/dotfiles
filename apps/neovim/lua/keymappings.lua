vim.api.nvim_command "packadd! which-key.nvim"
local wk = require "which-key"
local utils = require "utils"

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Set leader to <Space>
vim.g.mapleader = " "

-- Swap command and colon in normal, visual, and operator pending.
-- This doesn't seem to work with which-key, so we use the api functions.
vim.api.nvim_set_keymap("", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("", ":", ";", { noremap = true })

-- Normal mappings
local mapping = {
    -- Move between windows using Ctrl-hjkl
    ["<C-h>"] = { "<C-w>h", "Move left" },
    ["<C-j>"] = { "<C-w>j", "Move down" },
    ["<C-k>"] = { "<C-w>k", "Move up" },
    ["<C-l>"] = { "<C-w>l", "Move right" },

    -- Resize windows using arrows
    ["<C-Up>"] = { ":resize +2<CR>", "Increase height" },
    ["<C-Down>"] = { ":resize -2<CR>", "Decrease height" },
    ["<C-Left>"] = { ":vertical resize -2<CR>", "Decrease width" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "Increase width" },

    -- Buffer line mappings
    ["<Tab>"] = { ":BufferNext<CR>", "Next tab" },
    ["<S-Tab>"] = { ":BufferPrevious<CR>", "Previous tab" },
    ["<S-x>"] = { ":BufferClose<CR>", "Close tab" },
    ["<A-h>"] = { ":BufferMovePrevious<CR>", "Move tab left" },
    ["<A-l>"] = { ":BufferMoveNext<CR>", "Move tab right" },

    -- Move text using Alt-jk
    ["<A-j>"] = { ":move +1<CR>==", "Move line down" },
    ["<A-k>"] = { ":move -2<CR>==", "Move line up" },

    ["U"] = { "<C-r>", "Redo" },
}
wk.register(mapping, { mode = "n" })

-- Insert mappings
mapping = {
    ["<C-s>"] = { "<Cmd>w<CR>", "Save" },
}
wk.register(mapping, { mode = "i" })

-- Visual mappings
mapping = {
    -- Make indenting not cancel selection
    ["<"] = { "<gv", "Decrease indent" },
    [">"] = { ">gv", "Increase indent" },

    -- Move text using Alt-jk
    ["<A-j>"] = { ":move '>+1<CR>==gv", "Move text down" },
    ["<A-k>"] = { ":move '<-2<CR>==gv", "Move text up" },

    -- Pasting over selection doesn't copy destroyed text
    ["p"] = { [[p:let @+=@0<CR>:let @"=@0<CR>]], "Paste" },
    ["<leader>a"] = { vim.lsp.buf.range_code_action, "Code action" },
}
wk.register(mapping, { mode = "v" })

-- Normal, visual, and operator pending mappings
mapping = {
    -- Move viewport using Shift-JK
    J = { "<C-d>", "Scroll down", noremap = false },
    K = { "<C-u>", "Scroll up", noremap = false },

    H = { "^", "Line start" },
    L = { "$", "Line end" },

    ["<C-a>"] = { ":keepjumps normal ggVG<CR>", "Select all" },
    ["<C-s>"] = { ":w<CR>", "Save" },

    q = { "<nop>", "which_key_ignore" },
    g = {
        j = { "J", "Join lines" }, -- Remap join
        a = { ":EasyAlign<CR>", "Align" },
        k = { "K", "Help" },
        f = { "gF", "Go to file" },
        t = { ":t.<CR>", "Duplicate line" },
        q = { "q", "Macro" },
        s = { "gq", "Format" },
    },
}
wk.register(mapping, { mode = "n" })
wk.register(mapping, { mode = "v" })
wk.register(mapping, { mode = "o" })

-- Terminal mappings
mapping = {
    -- Move between windows using Ctrl-hjkl
    ["<C-h>"] = { t "<C-\\><C-n><C-w>h", "Move left" },
    ["<C-j>"] = { t "<C-\\><C-n><C-w>j", "Move down" },
    ["<C-k>"] = { t "<C-\\><C-n><C-w>k", "Move up" },
    ["<C-l>"] = { t "<C-\\><C-n><C-w>l", "Move right" },
    ["<esc>"] = { t "<C-\\><C-n>", "Exit" },
}
wk.register(mapping, { mode = "t" })

-- Leader mappings
mapping = {
    q = { "<C-w>q", "Close" },
    e = { ":NvimTreeToggle<CR>", "Toggle explorer" },
    f = { ":Telescope find_files<CR>", "Find" },
    c = { ":BufferClose<CR>", "Close buffer" },
    h = { ":nohlsearch<CR>", "Cancel search" },
    j = { vim.lsp.buf.definition, "Jump to definition" },
    k = { vim.lsp.buf.hover, "Hover doc" },
    x = { "<cmd>OpenUrl<cr>", "Open url" },
    a = { vim.lsp.buf.code_action, "Code action" },

    t = {
        name = "+Trouble",
        t = { "<cmd>TroubleToggle<cr>", "Trouble" },
        w = {
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            "Workspace",
        },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
        r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    },
    D = {
        name = "+Debug",
        b = { "<cmd>DebugToggleBreakpoint<cr>", "Toggle breakpoint" },
        c = { "<cmd>DebugContinue<cr>", "Continue" },
        i = { "<cmd>DebugStepInto<cr>", "Step into" },
        o = { "<cmd>DebugStepOver<cr>", "Step over" },
        r = { "<cmd>DebugToggleRepl<cr>", "Toggle repl" },
        s = { "<cmd>DebugStart<cr>", "Start" },
    },
    g = {
        name = "+Git",
        j = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
        k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview hunk" },
        r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
        R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset buffer" },
        s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
        u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage sunk" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit for current file",
        },
    },
    l = {
        name = "+LSP",
        a = { vim.lsp.buf.code_action, "Code action" },
        d = {
            "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
            "Document diagnostics",
        },
        D = {
            "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
            "Workspace diagnostics",
        },
        f = { vim.lsp.buf.formatting_sync, "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        r = { vim.lsp.buf.rename, "Rename" },
        t = { "<cmd>LspTypeDefinition<cr>", "Type definition" },
        s = { "<cmd>SymbolsOutline<cr>", "Document symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace symbols",
        },
    },
    s = {
        name = "+Search",
        f = { "<cmd>Telescope find_files<cr>", "Find file" },
        m = { "<cmd>Telescope marks<cr>", "Marks" },
        M = { "<cmd>Telescope man_pages<cr>", "Man pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
    },
    S = {
        name = "+Session",
        s = { "<cmd>SaveSession<cr>", "Save session" },
        r = { "<cmd>RestoreSession<cr>", "Restore session" },
    },
}
wk.register(mapping, { prefix = "<leader>" })
