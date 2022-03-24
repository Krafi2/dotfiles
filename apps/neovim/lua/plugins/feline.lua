local fn = vim.fn

-- base00 = "#282c34" --> Default Background
-- base01 = "#353b45" --> Lighter Background (Used for status bars)
-- base02 = "#3e4451" --> Selection Background
-- base03 = "#545862" --> Comments, Invisibles, Line Highlighting
-- base04 = "#565c64" --> Dark Foreground (Used for status bars)
-- base05 = "#abb2bf" --> Default Foreground, Caret, Delimiters, Operators
-- base06 = "#b6bdca" --> Light Foreground (Not often used)
-- base07 = "#c8ccd4" --> Light Background (Not often used)
-- base08 = "#e06c75" --> Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
-- base09 = "#d19a66" --> Integers, Boolean, Constants, XML Attributes, Markup Link Url
-- base0A = "#e5c07b" --> Classes, Markup Bold, Search Text Background
-- base0B = "#98c379" --> Strings, Inherited Class, Markup Code, Diff Inserted
-- base0C = "#56b6c2" --> Support, Regular Expressions, Escape Characters, Markup Quotes
-- base0D = "#61afef" --> Functions, Methods, Attribute IDs, Headings
-- base0E = "#c678dd" --> Keywords, Storage, Selector, Markup Italic, Diff Changed
-- base0F = "#be5046" --> Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

local function vi_mode()
    local vimode = require "feline.providers.vi_mode"
    return {
        provider = function()
            local mode = vimode.get_vim_mode()
            return (" %s "):format(mode)
        end,
        hl = function()
            return {
                name = vimode.get_mode_highlight_name(),
                fg = "base01",
                bg = vimode.get_mode_color(),
                style = "bold",
            }
        end,
        icon = "",
        right_sep = function()
            return {
                str = " ",
                hl = {
                    name = vimode.get_mode_highlight_name() .. "Sep",
                    fg = vimode.get_mode_color(),
                    bg = "base02",
                },
            }
        end,
    }
end

local function file_info(opts)
    return {
        provider = {
            name = "file_info",
            opts = {
                type = "relative",
            },
        },
        hl = {
            fg = opts.fg,
            bg = opts.bg,
        },
        right_sep = { "slant_right", " " },
    }
end

local function make_diagnostic(severity, provider)
    local lsp = require "feline.providers.lsp"
    return function(opts)
        return {
            provider = provider,
            enabled = function()
                return lsp.diagnostics_exist(vim.diagnostic.severity[severity])
            end,
            hl = {
                fg = opts.fg,
                bg = opts.bg,
            },
        }
    end
end

local diagnostic_errors = make_diagnostic("ERROR", "diagnostic_errors")
local diagnostic_warnings = make_diagnostic("WARN", "diagnostic_warnings")
local diagnostic_hints = make_diagnostic("HINT", "diagnostic_hints")
local diagnostic_info = make_diagnostic("INFO", "diagnostic_info")

local function git_info(opts)
    return {
        provider = "git_branch",
        left_sep = {
            str = " ",
            hl = { bg = "base02" },
        },
        -- Color the branch name if there are any changes
        hl = function()
            local gsd = vim.b.gitsigns_status_dict

            local changed = false
            if gsd then
                for _, key in ipairs { "added", "changed", "removed" } do
                    local n = gsd[key]
                    if n and n > 0 then
                        changed = true
                        break
                    end
                end
            end

            return {
                fg = changed and opts.changed or opts.normal,
                bg = "base02",
                style = "bold",
            }
        end,
    }
end

local function line_info(opts)
    return {
        provider = function()
            return string.format("%d:%-2d", vim.fn.line ".", vim.fn.col ".")
        end,
        hl = {
            fg = opts.secondary,
            bg = opts.primary,
            style = "bold",
        },
        left_sep = {
            str = " ",
            hl = { fg = opts.primary, bg = opts.bg },
        },
        right_sep = {
            str = "▐",
            hl = { fg = opts.sep, bg = opts.primary },
        },
    }
end

local function line_percentage(opts)
    return {
        provider = function()
            local curr_line = fn.line "."
            local lines = fn.line "$"

            if curr_line == 1 then
                return "Top"
            elseif curr_line == lines then
                return "Bot"
            else
                return string.format(
                    "%d%%%%",
                    fn.round(curr_line / lines * 100)
                )
            end
        end,
        hl = {
            fg = opts.fg,
            bg = opts.bg,
            style = "bold",
        },
        left_sep = { str = "", hl = { bg = opts.bg } },
        right_sep = { str = "▐", hl = { bg = opts.bg, fg = opts.sep } },
    }
end

local function palette()
    local colors = vim.tbl_map(tostring, require("lbase").palette())
    colors.fg = colors.base05
    colors.bg = colors.base01
    return colors
end

local feline = require "feline"
feline.setup {
    theme = palette(),
    vi_mode_colors = {
        NORMAL = "base0D",
        INSERT = "base0B",
        COMMAND = "base0E",
        VISUAL = "base09",
        BLOCK = "base09",
        SELECT = "base09",
        REPLACE = "base0A",
        ["V-REPLACE"] = "base0A",
        OP = "base0D",
        ENTER = "base0D",
        MORE = "base0D",
        SHELL = "base0C",
        TERM = "base0C",
        NONE = "base07",
    },
    components = {
        active = {
            {
                vi_mode(),
                file_info {
                    fg = "base05",
                    bg = "base02",
                },
            },
            {},
            {
                diagnostic_errors { fg = "base08" },
                diagnostic_warnings { fg = "base09" },
                diagnostic_hints { fg = "base0C" },
                diagnostic_info { fg = "base0%" },
                {
                    provider = " ",
                    hl = { fg = "base02", bg = "base01" },
                },
                git_info {
                    changed = "base08",
                    normal = "base05",
                },
                line_info {
                    primary = "base0D",
                    secondary = "base01",
                    bg = "base02",
                    sep = "base0B",
                },
                line_percentage {
                    fg = "base01",
                    bg = "base0B",
                    sep = "base02",
                },
            },
        },
        inactive = {
            {
                file_info {
                    fg = "base04",
                    bg = "base02",
                },
            },
            {},
            {
                diagnostic_errors { fg = "base04" },
                diagnostic_warnings { fg = "base04" },
                diagnostic_hints { fg = "base04" },
                diagnostic_info { fg = "base04" },
                { provider = " ", hl = { fg = "base02" } },
                git_info {
                    changed = "base04",
                    normal = "base04",
                },
                line_info {
                    primary = "base04",
                    secondary = "base01",
                    bg = "base02",
                    sep = "base03",
                },
                line_percentage {
                    fg = "base01",
                    bg = "base03",
                    sep = "base02",
                },
            },
        },
    },
    force_inactive = {
        filetypes = {},
        buftypes = {},
        bufnames = {},
    },
}

local utils = require "utils"
if not utils.guard "feline" then
    utils.command("autocmd ColorScheme *", function()
        local theme = palette()
        feline.use_theme(theme)
    end)
end
