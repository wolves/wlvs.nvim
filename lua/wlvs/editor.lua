local M = {}

function M.init()
  require("better_escape").setup({
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    default_mappings = true,
    mappings = {
      i = {
        j = {
          k = "<Esc>",
          j = "<Esc>",
        },
      },
    },
  })

  require("treesj").setup({
    use_default_keymaps = false,
    max_join_length = 150,
  })

  require("colorizer").setup({
    filetypes = { "*", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
    user_default_options = {
      RGB = true,       -- #RGB hex codes
      RRGGBB = true,    -- #RRGGBB hex codes
      names = false,    -- "Name" codes like Blue
      RRGGBBAA = true,  -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = true,    -- CSS rgb() and rgba() functions
      hsl_fn = true,    -- CSS hsl() and hsla() functions
      css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true,    -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      virtualtext = "■",
    },
  })

  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "契" },
      topdelete = { text = "契" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    end,
  })

  require("neogit").setup({
    disable_commit_confirmation = true,
    kind = "floating",
    commit_editor = {
      kind = "tab",
    },
    popup = {
      kind = "floating",
    },
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  })

  -- NeoScroll Config
  local neoscroll = require("neoscroll")
  neoscroll.setup({})
  local keymap = {}
  keymap["<C-u>"] = function()
    neoscroll.ctrl_u({ duration = 80 })
  end
  keymap["<C-d>"] = function()
    neoscroll.ctrl_d({ duration = 80 })
  end
  keymap["<C-b>"] = function()
    neoscroll.ctrl_b({ duration = 250 })
  end
  keymap["<C-f>"] = function()
    neoscroll.ctrl_f({ duration = 250 })
  end
  keymap["<C-y>"] = function()
    neoscroll.scroll(-0.1, { move_cursor = false, duration = 80 })
  end
  keymap["<C-e>"] = function()
    neoscroll.scroll(0.1, { move_cursor = false, duration = 80 })
  end
  keymap["zt"] = function()
    neoscroll.zt({ half_win_duration = 150 })
  end
  keymap["zz"] = function()
    neoscroll.zz({ half_win_duration = 150 })
  end
  keymap["zb"] = function()
    neoscroll.zb({ half_win_duration = 150 })
  end

  local modes = { "n", "v", "x" }
  for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
  end

  -- Old Config
  -- require("neoscroll").setup({})
  -- require("neoscroll.config").set_mappings({
  --   ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "80" } },
  --   ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "80" } },
  --   ["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "250" } },
  --   ["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "250" } },
  --   ["<C-y>"] = { "scroll", { "-0.10", "false", "80" } },
  --   ["<C-e>"] = { "scroll", { "0.10", "false", "80" } },
  --   ["zt"] = { "zt", { "150" } },
  --   ["zz"] = { "zz", { "150" } },
  --   ["zb"] = { "zb", { "150" } },
  -- })

  require("toggleterm").setup({
    size = 20,
    hide_numbers = true,
    open_mapping = [[<C-\>]],
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 0.3, -- Bak has 2
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
  })

  -- Esc twice to get to normal mode
  vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])

  require("trouble").setup({
    auto_open = false,
    focus = true,
    -- use_diagnostic_signs = true,
  })

  require("todo-comments").setup({})
end

return M
