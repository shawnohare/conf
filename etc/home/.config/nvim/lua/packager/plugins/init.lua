return {
    { "github/copilot.vim", enabled = false },
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        lazy = false,
        -- opts for use with copilot-cmp
        opts = {
            panel = { enabled = false },
            suggestion = { enabled = false },
            filetypes = { ["*"] = true },
            copilot_node_command = 'node', -- Node.js version must be > 16.x
            server_opts_overrides = {},
        }
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua" },
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "<CurrentMajor>.*",
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp"
    },
    {
        'Exafunction/codeium.vim',
        lazy = true,
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            -- vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
            vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
            vim.keymap.set('i', '<M-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        end
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        ft = "norg",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
            },
        },
        -- dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    {
        "nvim-lualine/lualine.nvim",
        -- dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    { "windwp/nvim-autopairs", opts = {} },
    { "folke/trouble.nvim", opts = {} },
    {
        "folke/todo-comments.nvim",
        -- dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            highlight = {
                before = "", -- "fg" or "bg" or empty
                keyword = "bg", -- "wide" or "bg" or empty. (wide is the same as bg, but will also highlight surrounding characters)
                after = "", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS).*:]], -- pattern used for highlightng (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
        },
    },
    { "lewis6991/spaceless.nvim", opts = {} },
    { "lewis6991/gitsigns.nvim", opts = {} },
    { 'TimUntersberger/neogit', opts = {} },
    { "nvim-tree/nvim-tree.lua", opts = {} },
    {
        "folke/noice.nvim",
        enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- NOTE: notify view is a bit distracting
            -- "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                -- command_palette = true, -- position the cmdline and popupmenu together
                -- long_message_to_split = true, -- long messages will be sent to a split
                -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
    },
}
