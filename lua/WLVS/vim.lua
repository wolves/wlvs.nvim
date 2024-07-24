local M = {}

local function set_vim_g()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	vim.g.skip_ts_context_commentstring_nodule = true
end

local function set_vim_opts()
	local indent = 2

	local notify = {
		old = vim.notify,
		lazy = nil,
	}
	notify.lazy = function(...)
		local args = { ... }
		vim.defer_fn(function()
			if vim.notify == notify.lazy then
				notify.old(unpack(args))
			else
				vim.notify(unpack(args))
			end
		end, 300)
	end
	vim.notify = notify.lazy

	if vim.fn.has("nvim-0.9.0") == 1 then
		vim.opt.splitkeep = "screen"
	end

	vim.g.loaded_python3_provider = 0
	vim.g.loaded_perl_provider = 0
	--vim.g.ruby_host_prog = "/home/wlvs/.asdf/shims/ruby"

	-- Set neovim npm location when using pnpm global via asdf-vm
	-- if vim.fn.has("mac") then
	--   vim.notify("Setting up for Mac", vim.log.levels.WARN, { title = "Neovim: Mac Setup" })
	--   vim.g.node_host_prog = "$HOME/Library/pnpm/global/5/node_modules/neovim/bin/cli.js"
	-- else
	--   vim.notify("Setting up for Linux", vim.log.levels.WARN, { title = "Neovim: Linux Setup" })
	--   vim.g.node_host_prog = "$HOME/.local/share/pnpm/global/5/node_modules/neovim/bin/cli.js"
	-- end

	vim.opt.autowrite = true
	vim.opt.clipboard = "unnamedplus"
	vim.opt.conceallevel = 3
	vim.opt.confirm = true
	vim.opt.cursorline = true
	vim.opt.expandtab = true

	vim.o.formatoptions = "jcroqlnt"

	vim.opt.guifont = "FiraCode Nerd Font:h12"
	vim.opt.grepprg = "rg --vimgrep"
	vim.opt.grepformat = "%f:%l:%c:%m"
	vim.opt.hidden = true
	vim.opt.ignorecase = true
	vim.opt.inccommand = "nosplit"
	vim.opt.joinspaces = false
	vim.opt.list = true
	vim.opt.mouse = "a"
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.pumblend = 10
	vim.opt.pumheight = 10
	vim.opt.scrolloff = 4
	vim.opt.sidescrolloff = 8
	vim.opt.shiftround = true
	vim.opt.shiftwidth = indent
	vim.opt.showmode = false
	vim.opt.signcolumn = "yes"
	vim.opt.smartcase = true
	vim.opt.smartindent = true

	vim.opt.splitbelow = true
	vim.opt.splitright = true
	vim.opt.tabstop = indent
	vim.opt.termguicolors = true
	vim.opt.undofile = true
	vim.opt.undolevels = 10000
	vim.opt.updatetime = 200
	vim.opt.wildmode = "longest:full,full"
	vim.opt.wrap = false
	vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
	vim.opt.fillchars = {
		--   horiz = "━",
		--   horizup = "┻",
		--   horizdown = "┳",
		--   vert = "┃",
		--   vertleft = "┫",
		--   vertright = "┣",
		--   verthoriz = "╋",im.o.fillchars = [[eob: ,
		-- fold = " ",
		foldopen = "",
		-- foldsep = " ",
		foldclose = "",
	}

	-- Use proper syntax highlighting in code blocks
	local fences = {
		"lua",
		-- "vim",
		"json",
		"typescript",
		"javascript",
		"js=javascript",
		"ts=typescript",
		"shell=sh",
		"python",
		"sh",
		"console=sh",
	}
	vim.g.markdown_fenced_languages = fences
end

local function set_vim_filetypes()
	vim.filetype.add({
		extension = {
			templ = "templ",
		},
	})
end

local function set_vim_keymaps()
	local options = { noremap = false, silent = true }

	-- Move to splits
	vim.keymap.set("n", "<C-h>", "<C-w>h", options)
	vim.keymap.set("n", "<C-j>", "<C-w>j", options)
	vim.keymap.set("n", "<C-k>", "<C-w>k", options)
	vim.keymap.set("n", "<C-l>", "<C-w>l", options)

	-- Move to buffer
	vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", options)
	vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", options)

	-- Resize window using <ctrl> arrow keys
	vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", options)
	vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", options)
	vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", options)
	vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", options)

	-- Clear search with <esc>
	vim.keymap.set("", "<esc>", ":noh<esc>", options)
	vim.keymap.set("n", "gw", "*N", options)
	vim.keymap.set("x", "gw", "*N", options)
end

function M.init()
	set_vim_g()
	set_vim_opts()
	set_vim_filetypes()
	set_vim_keymaps()
end

return M
