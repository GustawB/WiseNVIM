return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            highlight = { enable = true },
            indent = { enable = true },
        })

        treesitter.install({
            "bash",
            "c",
            "cmake",
            "cpp",
            "dockerfile",
            "python",
            "json",
            "lua",
            "rust",
        })
    end,
}
