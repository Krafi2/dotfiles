local R = require "pears/rule"
-- require("pears").setup(function(c)
--     local function bracket(open, close)
--         c.pair(open, {
--             close = close,
--             -- Expand only if the next char is not alphanumeric
--             should_expand = R.any_of(R.match_next "%W", R.match_next "$"),
--         })
--     end
--
--     local function quote(open, close)
--         close = close or open
--         c.pair(open, {
--             close = close,
--             -- Expand if the neighboring characters are words chars
--             should_expand = R.all_of(
--                 R.any_of(R.match_prev "%W", R.match_prev "^"),
--                 R.any_of(R.match_next "%W", R.match_next "$")
--             ),
--         })
--     end
--
--     bracket("{", "}")
--     bracket("[", "]")
--     bracket("(", ")")
--     quote "\""
--     quote "\"\"\""
--     quote "'"
--     quote "'''"
--     quote "`"
--     quote "```"
--
--     c.remove_pair_on_outer_backspace(false)
--     c.remove_pair_on_inner_backspace(true)
--     c.expand_on_enter(true)
-- end)
require("pears").setup(function(c)
    c.pair("{", "}")
    c.pair("[", "]")
    c.pair("(", ")")
    -- c.pair "\""
    c.pair "\"\"\""
    c.pair "'"
    c.pair "'''"
    c.pair "`"
    c.pair "```"

    c.remove_pair_on_outer_bakspace(false)
    c.remove_pair_on_inner_backspace(true)
    c.expand_on_enter(true)
end)
