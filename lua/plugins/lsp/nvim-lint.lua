return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            python = { "ruff", "mypy" },
            markdown = { "markdownlint" },
            lua = { "luacheck" },
            sql = { "sqruff" },
            cmake = { "cmakelang" },
        }
    end,
}
