return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                "pyright",
                "rust_analyzer",
                "jsonls",
                "markdown_oxide",
            },
        })

        local on_attach = function(_, _)
            vim.keymap.set("n", "gF", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Find refs" })
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local default_settings_servers = mason_lspconfig.get_installed_servers()
        for _, v in ipairs(default_settings_servers) do
            if v ~= "jdtls" then
                vim.lsp.config(v, {
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end
        end
    end,
}
