vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.o.number = true

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
    virtual_text = false,
})

vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons",
    -- Dependency of lualine
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
    -- Dependency of telescope
    "https://github.com/nvim-lua/plenary.nvim",
    -- Dependency of telescope
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", data = { run = "make" } },
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/shortcuts/no-neck-pain.nvim",
    "https://github.com/brianhuster/live-preview.nvim",
    "https://github.com/lewis6991/hover.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/rrethy/vim-illuminate",
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/nvim-mini/mini.starter",
    "https://github.com/nvim-mini/mini.sessions",
    "https://github.com/lewis6991/gitsigns.nvim",
})

local oil = require("oil")
local mini_icons = require("mini.icons")
local lualine = require("lualine")
local telescope_builtin = require("telescope.builtin")
local nvim_treesitter = require("nvim-treesitter")
local no_neck_pain = require("no-neck-pain")
local hover = require("hover")
local conform = require("conform")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local lint = require("lint")
local blink = require("blink.cmp")
local autopairs = require("nvim-autopairs")
local kanagawa = require("kanagawa")
local mini_starter = require("mini.starter")
local mini_sessions = require("mini.sessions")
local gitsigns = require("gitsigns")

oil.setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
            return name == "." or name == ".."
        end,
    },
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    float = {
        padding = 2,
        max_width = 0.8,
        max_height = 0.8,
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        win_options = {
            winblend = 0,
        },
        get_win_title = nil,
        preview_split = "auto",
        override = function(conf)
            return conf
        end,
    },
    confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 1.0,
        min_height = { 5, 0.1 },
        height = nil,
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        win_options = {
            winblend = 0,
        },
    },
    progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        minimized_border = "none",
        win_options = {
            winblend = 0,
        },
    },
})

mini_icons.setup()

lualine.setup({
    theme = "gruvbox-light",
    sections = {
        lualine_c = { { "filename", path = 1 }, "lsp_status" },
    },
})

nvim_treesitter.setup({
    highlight = { enable = true },
    indent = { enable = true },
})
nvim_treesitter.install({
    "bash",
    "c",
    "cmake",
    "cpp",
    "dockerfile",
    "python",
    "json",
    "lua",
    "rust",
    "cuda",
    "markdown",
    "sql",
})

no_neck_pain.setup({
    autocmds = {
        skipEnteringNoNeckPainBuffer = true,
    },
    width = 120,
})

hover.setup({
    providers = {
        "hover.providers.diagnostic",
        "hover.providers.lsp",
        "hover.providers.man",
    },
    preview_opts = {
        border = "single",
    },
    preview_window = false,
    title = true,
})

conform.setup({
    formatters_by_ft = {
        json = { "prettier" },
        lua = { "stylua" },
        python = { "ruff", "mypy" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        markdown = { "markdownlint" },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout = 500,
    },
})

mason.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})

mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
        "jsonls",
        "markdown_oxide",
        "rust_analyzer",
    },
})

mason_tool_installer.setup({
    ensure_installed = {
        "prettier",
        "stylua",
        "ruff",
        "mypy",
        "clang-format",
        "markdownlint",
        "sqruff",
        "cmakelang",
    },
    run_on_start = true,
})

local default_settings_servers = mason_lspconfig.get_installed_servers()
local capabilities = blink.get_lsp_capabilities()
for _, v in ipairs(default_settings_servers) do
    if v ~= "jdtls" then
        vim.lsp.config(v, {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        --vim.lsp.enable(v)
    end
end

lint.linters_by_ft = {
    python = { "ruff", "mypy" },
    markdown = { "markdownlint" },
    lua = { "luacheck" },
    sql = { "sqruff" },
    cmake = { "cmakelang" },
}

blink.setup({
    keymap = {
        preset = "none",
        ["<C-p>"] = { "select_prev" },
        ["<C-n>"] = { "select_next" },
        ["<Tab>"] = { "accept" },
    },
    completion = {
        documentation = { auto_show = true },
        menu = {
            draw = {
                columns = {
                    { "kind_icon" },
                    { "kind" },
                    { "label", "label_description", gap = 1 },
                    { "source_name" },
                },
                components = {
                    source_name = {
                        width = { max = 30 },
                        text = function(ctx)
                            return "[" .. ctx.source_name .. "]"
                        end,
                        highlight = "BlinkCmpSource",
                    },
                },
            },
        },
    },
})

autopairs.setup({
    event = "InsertEnter",
    config = true,
})

kanagawa.setup({
    keywordStyle = { italic = false },
})

mini_sessions.setup()

mini_starter.setup({
    evaluate_single = true,
    items = {
        mini_starter.sections.builtin_actions(),
        mini_starter.sections.recent_files(10, false),
        mini_starter.sections.sessions(5, true),
    },
    content_hooks = {
        mini_starter.gen_hook.adding_bullet(),
        mini_starter.gen_hook.indexing("all", { "Builtin actions" }),
        mini_starter.gen_hook.padding(3, 2),
        mini_starter.gen_hook.aligning("center", "center"),
    },
})

vim.cmd("colorscheme kanagawa-dragon")

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--query-driver=/**/*",
    },
})

vim.keymap.set("n", "<leader>e", require("oil").open_float, { desc = "Open Oil floating window" })

vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>r", telescope_builtin.lsp_references, { desc = "Telescope find refs" })
vim.keymap.set("n", "<leader>l", telescope_builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>g", telescope_builtin.grep_string, { desc = "Telescope grep string" })
vim.keymap.set("n", "<leader>i", telescope_builtin.lsp_implementations, { desc = "Telescope implementations" })
vim.keymap.set("n", "<leader>d", telescope_builtin.lsp_definitions, { desc = "Telescope definitions" })
vim.keymap.set("n", "<leader>t", telescope_builtin.lsp_type_definitions, { desc = "Telescope type_definitions" })
vim.keymap.set("n", "<leader>xx", telescope_builtin.diagnostics, { desc = "Telescope workspace diagnostics" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "bash", "c", "cmake", "cpp", "cuda", "dockerfile", "json", "lua", "markdown", "python", "rust", "sql" },
    callback = function()
        vim.treesitter.start()
    end,
})

vim.keymap.set("n", "<leader>n", "<cmd>NoNeckPain<CR>", { desc = "Toggle NoNeckPain" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("update")
        end
    end,
})

vim.keymap.set("n", "K", function()
    require("hover").open()
end, { desc = "hover.nvim (open)" })

vim.keymap.set("n", "<C-S>", function()
    vim.ui.input({ prompt = "Session Name: " }, function(input)
        if input and input ~= "" then
            mini_sessions.write(input)
        end
    end)
end, { desc = "Create new session" })
