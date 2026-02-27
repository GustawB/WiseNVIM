require("config.lazy")

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.o.number = true

local map = vim.keymap.set

map("n", "<leader>e", require("oil").open_float, { desc = "Open Oil floating window" })

local builtin = require("telescope.builtin")
map("n", "<leader>tf", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>tr", builtin.lsp_references, { desc = "Telescope find refs" })
map("n", "<leader>tg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>ti", builtin.lsp_implementations, { desc = "Telescope implementations" })
map("n", "<leader>td", builtin.lsp_definitions, { desc = "Telescope definitions" })
map("n", "<leader>tt", builtin.lsp_type_definitions, { desc = "Telescope type_definitions" })

map("n", "<C-S>", function()
    vim.ui.input({ prompt = "Session Name: " }, function(input)
        if input and input ~= "" then
            require("mini.sessions").write(input)
        end
    end)
end, { desc = "Create new session" })
map("n", "<leader>n", "<cmd>NoNeckPain<CR>", { desc = "Toggle NoNeckPain" })

vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
    virtual_text = false,
})

vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float)

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

--vim.api.nvim_create_autocmd("UILeave", {
--    callback = function()
--        io.write("\027]111\027\\")
--    end,
--})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("update")
        end
    end,
})
