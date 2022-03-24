local plugin = require("utils").plugin

-- Packer config
require "plugins/packer"

-- Setup plugins
return require("packer").startup(function()
    -- Have packer manage itself, ignore config
    plugin { "wbthomason/packer.nvim", config = "" }

    -- Dev
    plugin { "folke/lua-dev.nvim" }
    plugin { "nvim-lua/plenary.nvim" }
    plugin { "nvim-lua/popup.nvim" }
    plugin { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    plugin { "nvim-treesitter/playground" }
    plugin { "simrat39/rust-tools.nvim" }
    plugin { "Saecki/crates.nvim" }

    -- Lsp
    plugin { "neovim/nvim-lspconfig" }
    plugin { "williamboman/nvim-lsp-installer" }
    plugin {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    }
    -- Colors
    plugin { "rktjmp/lush.nvim" }
    plugin { "Krafi2/lbase16.nvim", requires = "rktjmp/lush.nvim" }
    plugin { "norcalli/nvim-colorizer.lua" }

    -- UI
    plugin { "lukas-reineke/indent-blankline.nvim" }
    plugin { "lewis6991/gitsigns.nvim" }
    plugin { "romgrk/barbar.nvim" }
    plugin { "kyazdani42/nvim-web-devicons" }
    plugin { "kyazdani42/nvim-tree.lua", requires = "nvim-web-devicons" }
    plugin { "ray-x/lsp_signature.nvim" }
    plugin { "folke/zen-mode.nvim" }
    plugin { "famiu/feline.nvim", after = "lbase16.nvim" }
    plugin { "folke/trouble.nvim" }
    plugin { "simrat39/symbols-outline.nvim" }
    plugin { "akinsho/toggleterm.nvim" }
    plugin { "luukvbaal/stabilize.nvim" }

    -- Completion
    plugin { "hrsh7th/nvim-cmp" }
    plugin { "hrsh7th/cmp-nvim-lsp" }
    plugin { "hrsh7th/cmp-buffer" }
    plugin { "hrsh7th/cmp-path" }
    plugin { "L3MON4D3/LuaSnip" }

    -- Text manipulation
    plugin { "numToStr/Comment.nvim" }
    plugin { "junegunn/vim-easy-align" }
    plugin { "steelsojka/pears.nvim" }

    -- Markdown
    plugin { "plasticboy/vim-markdown" }
    plugin { "vhyrro/neorg", after = "nvim-treesitter" }

    -- Motion
    plugin { "abecodes/tabout.nvim" }
    plugin { "ggandor/lightspeed.nvim" }
    plugin { "Krafi2/jeskape.nvim" }

    -- Quality of life
    plugin { "folke/which-key.nvim" }
    plugin {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    }
    plugin { "karb94/neoscroll.nvim", event = "WinScrolled" }
    plugin { "rmagatti/auto-session" }
    plugin { "pbrisbin/vim-mkdir" }
    plugin { "lambdalisue/suda.vim" }
    plugin { "ahmedkhalf/project.nvim" }
    plugin { "famiu/bufdelete.nvim" }
    plugin { "Mephistophiles/vim-sleuth" }
    plugin { "wsdjeg/vim-fetch" }
end)
