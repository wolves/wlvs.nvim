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
		-- variablebuiltinStyle = { italic = true },
		-- specialReturn = true, -- special highlight for the return keyword
		-- specialException = true, -- special highlight for exception handling keywords
		transparent = false, -- do not set background color
		dimInactive = true,
		globalStatus = true,
		colors = {},
		-- overrides = function(colors)
		--   return {
		--     CursorLine = { bg = colors.palette.winterBlue },
		--   }
		-- end,
		theme = "wave",
		background = {
			dark = "wave",
			light = "lotus",
		},
	})

	vim.cmd("colorscheme kanagawa-wave")
end

return M
