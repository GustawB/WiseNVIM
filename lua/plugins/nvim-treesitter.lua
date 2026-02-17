return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  opts = {
    ensure_installed = {
	"lua",
	"rust",
	"python",
	"c",
	"c++",
    }
  },
}
