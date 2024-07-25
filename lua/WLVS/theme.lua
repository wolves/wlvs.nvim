local M = {}

local kanagawa = require("kanagawa")

function M.init()
	kanagawa.setup({
		compile = false,
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false, -- do not set background color
		dimInactive = true,
		globalStatus = true,
		colors = {},
		theme = "wave",
		background = {
			dark = "wave",
			light = "lotus",
		},
	})

	vim.cmd("colorscheme kanagawa-wave")
end

return M
