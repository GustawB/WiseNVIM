require("config.lazy")

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.o.number = true

local map = vim.keymap.set
vim.keymap.set("n", "K", function()
    require("hover").open()
end, { desc = "hover.nvim (open)" })
map("n", "<leader>e", require("oil").open_float, { desc = "Open Oil floating window" })

local builtin = require("telescope.builtin")
map("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>r", builtin.lsp_references, { desc = "Telescope find refs" })
map("n", "<leader>l", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>g", builtin.grep_string, { desc = "Telescope grep string" })
map("n", "<leader>i", builtin.lsp_implementations, { desc = "Telescope implementations" })
map("n", "<leader>d", builtin.lsp_definitions, { desc = "Telescope definitions" })
map("n", "<leader>t", builtin.lsp_type_definitions, { desc = "Telescope type_definitions" })

map("n", "<C-S>", function()
    vim.ui.input({ prompt = "Session Name: " }, function(input)
        if input and input ~= "" then
            require("mini.sessions").write(input)
        end
    end)
end, { desc = "Create new session" })
map("n", "<leader>n", "<cmd>NoNeckPain<CR>", { desc = "Toggle NoNeckPain" })

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

local dap = require("dap")
vim.keymap.set("n", "<Up>", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<Down>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<Right>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<Left>", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>pq", dap.terminate, { desc = "Quit DAP Session " })

vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
    virtual_text = false,
})

-- vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float)
vim.keymap.set(
    { "n", "t" },
    "<C-t>",
    "<cmd>ToggleTerm direction=float<CR>",
    { noremap = true, silent = true, desc = "Toggle terminal" }
)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "bash", "c", "cmake", "cpp", "cuda", "dockerfile", "json", "lua", "markdown", "python", "rust", "sql" }, -- Just add more strings, bruh
    callback = function()
        vim.treesitter.start()
    end,
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
