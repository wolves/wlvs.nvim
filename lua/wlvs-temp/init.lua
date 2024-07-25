------------------------------------------------------------------------------//
--    _/          _/  _/      _/      _/    _/_/_/
--   _/          _/  _/      _/      _/  _/
--  _/    _/    _/  _/      _/      _/    _/_/
--   _/  _/  _/    _/        _/  _/          _/
--    _/  _/      _/_/_/_/    _/      _/_/_/
------------------------------------------------------------------------------//
local M = {}

function M.init()
	require("wlvs.vim").init()
	require("wlvs.autocmds").init()
	require("wlvs.theme").init()
	require("wlvs.keymaps").init()
	require("wlvs.telescope").init()
	require("wlvs.treesitter").init()
	require("wlvs.mini").init()
	require("wlvs.editor").init()
	require("wlvs.completion").init()
	require("wlvs.ui").init()
	require("wlvs.lsp").init()
end

return M
