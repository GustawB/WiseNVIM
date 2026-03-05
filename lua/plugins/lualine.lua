return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        theme = "gruvbox-light",
        sections = {
            lualine_c = { { "filename", path = 1 }, "lsp_status" },
        },
    },
}
