return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  opts = {
    highlight = { enable = true },
    ensure_installed = {
	"lua",
	"rust",
    }
  },
}
