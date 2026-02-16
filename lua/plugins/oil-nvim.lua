return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  config = function()
      require("oil").setup({
	default_file_explorer = true,
	columns = {
    	  "icon",
    	  "permissions",
    	  "size",
    	  "mtime",
  	},
	float = {
		padding = 2,
		max_width = 0.8,
		max_height = 0.8,
		border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
		win_options = {
			winblend = 0,
			--winhighlight = "FloatBorder:OilBorder,NormalFloat:OilBackground",
		},
		get_win_title = nil,
		preview_split = "auto",
		override = function(conf)
			return conf
		end,
	},
	confirmation = {
		max_width = 0.9,
		min_width = { 40, 0.4 },
		width = nil,
		max_height = 1.0,
		min_height = { 5, 0.1 },
		height = nil,
		border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
		win_options = {
			winblend = 0,
			--winhighlight = "FloatBorder:OilConfirmationBorder,NormalFloat:OilConfirmationBackground",
		},
	},
	progress = {
		max_width = 0.9,
		min_width = { 40, 0.4 },
		width = nil,
		max_height = { 10, 0.9 },
		min_height = { 5, 0.1 },
		height = nil,
		border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
		minimized_border = "none",
		win_options = {
			winblend = 0,
			--winhighlight = "FloatBorder:OilProgressBorder,NormalFloat:OilProgressBackground",
		},
	}})
end,
lazy = false,
}
