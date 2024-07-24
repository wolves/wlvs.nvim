------------------------------------------------------------------------------//
--    _/          _/  _/      _/      _/    _/_/_/
--   _/          _/  _/      _/      _/  _/
--  _/    _/    _/  _/      _/      _/    _/_/
--   _/  _/  _/    _/        _/  _/          _/
--    _/  _/      _/_/_/_/    _/      _/_/_/
------------------------------------------------------------------------------//
local M = {}

function M.init()
	require("WLVS.vim").init()
	require("WLVS.autocmds").init()
	require("WLVS.theme").init()
	require("WLVS.keymaps").init()
	require("WLVS.telescope").init()
	require("WLVS.treesitter").init()
	require("WLVS.mini").init()
	require("WLVS.editor").init()
	require("WLVS.completion").init()
	-- require 'wlvs.ui'.init()
	-- require 'wlvs.lsp'.init()
end

return M
