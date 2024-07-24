local M = {}

function M.grep_string_prompt()
	require("telescope.builtin").grep_string({
		path_display = { "shorten" },
		search = vim.fn.input("Grep String ❱ "),
	})
end

function M.grep_word()
	require("telescope.builtin").grep_string({
		path_display = { "shorten" },
		search = vim.fn.expand("<cword>"),
	})
end

function M.init()
	require("telescope").setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			layout_strategy = "horizontal",
			layout_config = {
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
			winblend = borderless and 0 or 10,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})

	require("telescope").load_extension("fzf")
end

return M
