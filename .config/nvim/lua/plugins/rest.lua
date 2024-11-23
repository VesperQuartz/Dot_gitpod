return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		lazy = false,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		lazy = false,
		dependencies = { "luarocks.nvim" },
		config = function() end,
		opts = {},
	},
}
