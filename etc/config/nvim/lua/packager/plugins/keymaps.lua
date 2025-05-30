return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.setup()
        wk.register({
            ["g"] = {
                R = { "<cmd>TroubleToggle lsp_references<cr>", "lsp references" },
                d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
            },
            ["<leader>"] = {
                b = {
                    name = "+buffer",
                    b = { "<cmd>Telescope buffers<cr>", "buffers" },
                    d = { "<cmd>bd<cr>", "delete" },
                    e = { "<cmd>enew<cr>", "new" },
                    h = { "<cmd>bp<cr>", "previous" },
                    l = { "<cmd>bn<cr>", "next" },
                    n = { "<cmd>enew<cr>", "new" },
                    p = { "<cmd>bp<cr>", "previous" },
                    s = { "<cmd>split<cr>", "split" },
                    v = { "<cmd>vsplit<cr>", "vert split" },
                },
                d = {
                    name = "+debug",
                    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "toggle breakpoint" },
                    c = { "<cmd>lua require'dap'.continue()<cr>", "continue" },
                    i = { "<cmd>lua require'dap'.step_into()<cr>", "step into" },
                    o = { "<cmd>lua require'dap'.step_over()<cr>", "step over" },
                    u = { "<cmd>lua require'dap'.step_out()<cr>", "step out" },
                    r = { "<cmd>lua require'dap'.repl.open()<cr>", "repl" },
                    s = { "<cmd>lua require'dap'.continue()<cr>", "start" },
                },
                f = {
                    name = "+find",
                    b = { "<cmd>Telescope buffers<cr>", "buffers" },
                    e = { "<cmd>NvimTreeToggle<cr>", "explorer" },
                    f = { "<cmd>Telescope find_files<cr>", "files" },
                    g = { "<cmd>Telescope live_grep<cr>", "grep" },
                    h = { "<cmd>Telescope help_tags<cr>", "help" },
                    m = { "<cmd>Telescope marks<cr>", "marks" },
                    r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
                    t = { "<cmd>TodoTelescope<cr>", "todos" },
                    w = { "<cmd>Telescope file_browser<cr>", "file browser" },
                },
                g = {
                    name = "+git",
                    b = { "<cmd>Neogit branch<cr>", "branch" },
                    c = { "<cmd>Neogit commit<cr>", "commit" },
                    s = { "<cmd>Neogit<cr>", "status" },
                    -- b = {"<cmd>Telescope git_branches<cr>", "branch"},
                    -- c = {"<cmd>Telescope git_commits<cr>", "commit"},
                    -- s = {"<cmd>Telescope git_status<cr>", "status"},
                },
                h = {
                    name = "+help",
                    h = { "<cmd>Telescope help_tags<cr>", "help" },
                    t = { "<cmd>TodoTelescope<cr>", "todos" },
                    k = { "<cmd>Telescope keymaps<cr>", "keymaps" },
                },
                l = {
                    name = "+lsp",
                    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "declaration" },
                    R = { "<cmd>lua vim.lsp.buf.references()<cr>", "references" },
                    S = { "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "workspace symbols" },
                    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
                    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
                    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
                    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },
                    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "implementation" },
                    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
                    s = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "document symbols" },
                    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "type definition" },
                },
                x = {
                    name = "+trouble (diagnostics)",
                    x = { "<cmd>TroubleToggle<cr>", "toggle" },
                    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics" },
                    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document diagnostics" },
                    l = { "<cmd>TroubleToggle loclist<cr>", "location list" },
                    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
                    r = { "<cmd>TroubleToggle lsp_references<cr>", "lsp references" },
                    f = { "<cmd>lua vim.diagnostic.open_float()<CR>" },
                    -- l = {"<cmd>lua vim.diagnostic.setloclist()<CR>"},
                    n = { "<cmd>lua vim.diagnostic.goto_next()<CR>" },
                    p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
                    -- q = {"<cmd>lua vim.diagnostic.setqflist()<CR>"}
                },
            },
        })
    end
}
