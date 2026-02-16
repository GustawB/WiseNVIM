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

-- vim.api.nvim_set_hl(0, "OilBorder", { fg = "#BD93F9", bg = "#1e1e2e" })
-- vim.api.nvim_set_hl(0, "OilBackground", { bg = "#1e1e2e" })

-- vim.api.nvim_set_hl(0, "OilConfirmationBorder", { fg = "#8F2222", bg = "#010115" })
-- vim.api.nvim_set_hl(0, "OilConfirmationBackground", { bg = "#010115" })

-- vim.api.nvim_set_hl(0, "OilProgressBorder", { fg = "#DAE01B", bg = "#010115" })
-- vim.api.nvim_set_hl(0, "OilProgressBackground", { bg = "#010115" })

vim.diagnostic.config({
	virtual_lines = true,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*.rs' },
  callback = function() vim.treesitter.start() end,
})
