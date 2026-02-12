return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
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
    		-- Padding around the floating window
   		 padding = 2,
    		-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    		max_width = 0.8,
    		max_height = 0.8,
    		border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
    		win_options = {
      			winblend = 0,
				winhighlight = "FloatBorder:OilBorder,NormalFloat:OilBackground",
    		},
    		-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
   		 get_win_title = nil,
    		-- preview_split: Split direction: "auto", "left", "right", "above", "below".
    		preview_split = "auto",
    		-- This is the config that will be passed to nvim_open_win.
    		-- Change values here to customize the layout
    		override = function(conf)
      		return conf
    		end,
	},
      confirmation = {
	      	-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    		-- min_width and max_width can be a single value or a list of mixed integer/float types.
    		-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
		max_width = 0.9,
		-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
		min_width = { 40, 0.4 },
		-- optionally define an integer/float for the exact width of the preview window
		width = nil,
		-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_height and max_height can be a single value or a list of mixed integer/float types.
		-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
		max_height = 1.0,
		-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
		min_height = { 5, 0.1 },
		-- optionally define an integer/float for the exact height of the preview window
		height = nil,
		border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
		win_options = {
			winblend = 0,
			winhighlight = "FloatBorder:OilConfirmationBorder,NormalFloat:OilConfirmationBackground",
		},
	},
	-- Configuration for the floating progress window
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
		  winhighlight = "FloatBorder:OilProgressBorder,NormalFloat:OilProgressBackground",
	    },
	  }})
  end,
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
