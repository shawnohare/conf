return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup {
            auto_install = true,
            ensure_installed = "all", -- one of "all", "language", or a list of languages
            highlight = {
                enable = true,
                -- additional_vim_regex_highlighting = {'org'},
                -- disable = { "c", "rust"},  -- list of language that will be disabled
            },
            indent = {
              enable = true,
              disable = {"python"},
              -- disable = {'yaml'},
            },
            -- incremental_selection = {
            --   enable = true,
            --   keymaps = {
            --     init_selection = "gnn",
            --     node_incremental = "grn",
            --     scope_incremental = "grc",
            --     node_decremental = "grm",
            --   },
            -- },
            -- refactor = {
            --   highlight_definitions = {
            --    enable = true,
            --  },
            --},
        }
    end
}
