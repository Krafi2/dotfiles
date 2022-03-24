require("crates").setup {
    avoid_prerelease = true,
    autoload = true,
    autoupdate = true,
    loading_indicator = true,
    text = {
        loading = "Loading...",
        version = "%s",
        prerelease = "%s",
        yanked = "%s yanked",
        nomatch = "No match",
        upgrade = "  %s",
        error = "Error fetching version",
    },
    highlight = {
        loading = "CratesNvimLoading",
        version = "CratesNvimVersion",
        prerelease = "CratesNvimPreRelease",
        yanked = "CratesNvimYanked",
        nomatch = "CratesNvimNoMatch",
        upgrade = "CratesNvimUpgrade",
        error = "CratesNvimError",
    },
    popup = {
        text = {
            yanked = "yanked",
        },
        highlight = {
            yanked = "CratesNvimPopupYanked",
        },
        keys = {
            hide = { "q", "<esc>" },
            select = { "<cr>" },
            copy_version = { "yy" },
        },
        style = "minimal",
        border = "solid",
        max_height = 30,
        min_width = 20,
    },
}
