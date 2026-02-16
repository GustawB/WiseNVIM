require("config.lazy")

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.o.number = true

local map = vim.keymap.set

map('n', '<leader>e', require("oil").open_float, { desc = 'Open Oil floating window' })
map('n', '<leader>t', '<cmd>Telescope find_files<CR>', { desc = 'Telescope find files' })

map('n', 'gF', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gR', '<cmd>Telescope lsp_references<CR>', { desc = 'Find refs' })

vim.api.nvim_set_option("clipboard", "unnamed")

vim.diagnostic.config({
	virtual_lines = true,
})
