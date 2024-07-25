local M = {}

function M.init()
	require("ts_context_commentstring").setup({})
	require("nvim-treesitter.configs").setup({
		sync_install = false,
		auto_install = false,
		highlight = { enable = true },
		indent = { enable = false },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = "<C-s>",
				node_decremental = "<C-bs>",
			},
		},
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
		textobjects = {
			select = {
				enable = false,
			},
			move = {
				enable = false,
			},
			lsp_interop = {
				enable = false,
			},
		},
	})
end

return M
