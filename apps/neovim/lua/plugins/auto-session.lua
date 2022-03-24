local function close_nvim_tree()
    -- nvim-tree may or may not be installed
    pcall(vim.api.nvim_command, "NvimTreeClose")
end

require("auto-session").setup {
    log_level = "error",
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
    pre_save_cmds = { close_nvim_tree },
}
