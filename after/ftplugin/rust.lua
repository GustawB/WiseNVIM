local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>me", function()
    vim.cmd.RustLsp("expandMacro")
end, { silent = true, buffer = bufnr })
