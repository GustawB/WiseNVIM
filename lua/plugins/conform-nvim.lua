return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function()
        local conform = require("conform")

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
    end,
}
