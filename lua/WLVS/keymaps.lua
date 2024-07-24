local M = {}
local util = require("util")

grep_string_prompt = require("WLVS.telescope").grep_string_prompt
grep_word = require("WLVS.telescope").grep_word

function M.init()
	local wk = require("which-key")

	wk.setup({
		show_help = false,
		plugins = { spelling = true },
	})
	wk.add({
		{
			mode = { "n", "v" },
			{ "<leader>b", group = "+buffer" },
			{ "<leader>c", group = "+code" },
			{ "<leader>f", group = "+file" },
			{ "<leader>g", group = "+git" },
			{ "<leader>h", group = "+help" },
			{ "<leader>n", group = "+noice" },
			{ "<leader>q", group = "+quit/session" },
			{ "<leader>s", group = "+search" },
			{ "<leader>x", group = "+diagnostics/quickfix" },
			{ "[", group = "+prev" },
			{ "]", group = "+next" },
			{ "g", group = "+goto" },
		},
	})

	vim.o.timeoutlen = 300

	wk.add({
		{ "<leader>w", "<cmd>w!<CR>", desc = "Save" },
		{ "<leader>q", "<cmd>q!<CR>", desc = "Quit" },
		{ "<leader><space>", util.telescope("find_files"), desc = "Find Files" },
		{ "<leader>b", group = "+buffer" },
		{
			"<leader>bb",
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			desc = "Buffers",
		},
		{
			"<leader>bd",
			"<cmd>lua require('mini.bufremove').delete(0, false)<CR>",
			desc = "Delete Buffer",
		},
		{ "<leader>e", "<cmd>lua require('mini.files').open()<CR>", desc = "File Explorer" },
		{ "<leader>f", group = "+file" },
		{ "<leader>fn", "<cmd>enew<CR>", desc = "New" },
		{ "<leader>g", group = "+git" },
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview" },
		{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
		{ "<leader>gh", group = "+hunk" },

		{ "<leader>gJ", "<cmd>TSJJoin<cr>", desc = "Join" },
		{ "<leader>gS", "<cmd>TSJSplit<cr>", desc = "Split" },

		{ "<leader>m", group = "+harpoon" },
		{ "<leader>s", group = "+search" },
		{ "<leader>ss", grep_string_prompt, desc = "Grep Prompt" },
		{ "<leader>sw", grep_word, desc = "Grep Current Word" },
		{ "<leader>t", group = "+toggle" },
		{ "<leader>tc", util.toggle_colors, desc = "Colorscheme Light/Dark" },
		{ "<leader>tf", require("wlvs.lsp.format").toggle, desc = "Format on Save" },
		{
			"<leader>tn",
			function()
				util.toggle("relativenumber", true)
				util.toggle("number")
			end,
			desc = "Line Numbers",
		},
		{
			"<leader>ts",
			function()
				util.toggle("spell")
			end,
			desc = "Spelling",
		},
		{
			"<leader>tw",
			function()
				util.toggle("wrap")
			end,
			desc = "Word Wrap",
		},
		{ "<leader>x", group = "+trouble/todo" },
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todo Trouble" },
		{ "<leader>xT", "<cmd>TodoTelescope<CR>", desc = "Todo Telescope" },
	})

	-- Ignore <leader> with numerals
	local ignores = {}
	for i = 0, 10 do
		table.insert(ignores, { "<leader>" .. tostring(i), hidden = true })
	end
	wk.add(ignores)

	wk.add({
		{ "g", group = "+goto" },
	})
end

return M
