require("config.lazy")

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.o.number = true

local map = vim.keymap.set

map("n", "<leader>e", require("oil").open_float, { desc = "Open Oil floating window" })
map("n", "<leader>t", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })

vim.api.nvim_set_option("clipboard", "unnamed")

vim.diagnostic.config({
    virtual_lines = true,
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function()
        io.write("\027]111\027\\")
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("update")
        end
    end,
})
