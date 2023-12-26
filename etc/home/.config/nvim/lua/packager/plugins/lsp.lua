return {
    { "williamboman/mason.nvim", lazy = true, build = ":MasonUpdate", opts = {} },
    { "williamboman/mason-lspconfig.nvim", lazy = true, opts = {} },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            'hrsh7th/nvim-cmp',

        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            -- Merge the capabilities of nvim-cmp and lspconfig.
            local defaults = {
                flags = {
                    debounce_text_changes = 150,
                },
                capabilities = require('cmp_nvim_lsp').default_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                ),
                on_attach = function(client, bufnr)
                    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
                end
            }

            -- Update global default config to apply to all servers.
            lspconfig.util.default_config = vim.tbl_deep_extend(
              'force',
              lspconfig.util.default_config,
              defaults
            )

        mason_lspconfig.setup({
            ensure_installed = {
                "biome",  -- js, json
                "bashls",
                -- "fennel_language_server",
                "html",
                "lua_ls",
                "pyright",
                "ruff_lsp",
                "marksman",
                "prosemd_lsp",
                -- "nil_ls",       -- nix, TODO: cannot compile in some cases?
                -- "teal_ls",   -- TODO: luarocks issue
                "taplo",        -- toml
                "terraformls",
                "tflint",
                "lemminx",      -- xml
                "yamlls",
                -- "yaml-language-server",
                -- "yamllint",
                -- "pyright",
                -- "pylint",
              }
            })

            mason_lspconfig.setup_handlers({
                function (server_name)
                    require("lspconfig")[server_name].setup({})
                end,
                -- server specific handlers go here.
                ["lua_ls"] = function()
                    require("lspconfig")["lua_ls"].setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {"vim", "hs"}
                                },
                            },
                        },
                    })
                end,
            })

        end
    },


}
