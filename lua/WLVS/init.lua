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
	-- require 'wlvs.treesitter'.init()
	-- require 'wlvs.mini'.init()
	-- require 'wlvs.editor'.init()
	-- require 'wlvs.coding'.init()
	-- require 'wlvs.plugins.completion'.init()
	-- require 'wlvs.ui'.init()
	-- require 'wlvs.lsp'.init()
end

return M
