vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
 { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        rust = { 'rustfmt' },
      },
    },
  },
	{
	  "folke/tokyonight.nvim",
	  lazy = false,
	  priority = 1000,
	  opts = {},
	  config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
			})
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{ 'terrortylor/nvim-comment' },
	{
	    'windwp/nvim-autopairs',
	    event = "InsertEnter",
	    config = true
	    -- use opts = {} for passing setup options
	    -- this is equivalent to setup({}) function
	},
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
	},
	{
		-- file explorer
		'stevearc/oil.nvim',
		opts = {},
	},
	{
		  "ray-x/lsp_signature.nvim",
		  event = "VeryLazy",
		  opts = {},
		  config = function(_, opts) require'lsp_signature'.setup(opts) end
	},
	--  mason to manage lsp servers
	{
	"williamboman/mason.nvim",
	-- lsp stuff
	},
	-- lsp support
	{ "neovim/nvim-lspconfig" },
	-- completion stuff
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	-- telescope
	{ "nvim-telescope/telescope.nvim", tag = "0.1.5" },
	-- dependency for telescope
	"nvim-lua/plenary.nvim",

	-- Mason setup
	"williamboman/mason-lspconfig.nvim",
	"nvim-tree/nvim-tree.lua",
	-- treesitter stuff
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
		  'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	{
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "v"}, "<up>",
            function() mc.lineAddCursor(-1) end)
        set({"n", "v"}, "<down>",
            function() mc.lineAddCursor(1) end)
        set({"n", "v"}, "<leader><up>",
            function() mc.lineSkipCursor(-1) end)
        set({"n", "v"}, "<leader><down>",
            function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "v"}, "<leader>n",
            function() mc.matchAddCursor(1) end)
        set({"n", "v"}, "<leader>s",
            function() mc.matchSkipCursor(1) end)
        set({"n", "v"}, "<leader>N",
            function() mc.matchAddCursor(-1) end)
        set({"n", "v"}, "<leader>S",
            function() mc.matchSkipCursor(-1) end)

        -- Add all matches in the document
        set({"n", "v"}, "<leader>A", mc.matchAllAddCursors)

        -- You can also add cursors with any motion you prefer:
        -- set("n", "<right>", function()
        --     mc.addCursor("w")
        -- end)
        -- set("n", "<leader><right>", function()
        --     mc.skipCursor("w")
        -- end)

        -- Rotate the main cursor.
        set({"n", "v"}, "<left>", mc.nextCursor)
        set({"n", "v"}, "<right>", mc.prevCursor)

        -- Delete the main cursor.
        set({"n", "v"}, "<leader>x", mc.deleteCursor)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)

        -- Easy way to add and remove cursors using the main cursor.
        set({"n", "v"}, "<c-q>", mc.toggleCursor)

        -- Clone every cursor and disable the originals.
        set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors)

        set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler.
            end
        end)

        -- bring back cursors if you accidentally clear them
        set("n", "<leader>gv", mc.restoreCursors)

        -- Align cursor columns.
        set("n", "<leader>a", mc.alignCursors)

        -- Split visual selections by regex.
        set("v", "S", mc.splitCursors)

        -- Append/insert for each line of visual selections.
        set("v", "I", mc.insertVisual)
        set("v", "A", mc.appendVisual)

        -- match new cursors within visual selections by regex.
        set("v", "M", mc.matchCursors)

        -- Rotate visual selection contents.
        set("v", "<leader>t",
            function() mc.transposeCursors(1) end)
        set("v", "<leader>T",
            function() mc.transposeCursors(-1) end)

        -- Jumplist support
        set({"v", "n"}, "<c-i>", mc.jumpForward)
        set({"v", "n"}, "<c-o>", mc.jumpBackward)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}

})


-- comment with Shift+c, I think?
require('nvim_comment').setup()
-- completion plugin setup
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

-- completion is working with the below keybindings
cmp.setup({
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['C-e'] = cmp.mapping.abort(),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-]>'] = cmp.mapping.select_prev_item(),
		['<C-\\>'] = cmp.mapping.select_next_item(),

		-- Scroll up and down in the completion documentation
		['C-f'] = cmp.mapping.scroll_docs(-4),
		['C-d'] = cmp.mapping.scroll_docs(4),
	}),
	-- nvim_lsp apparently retrieves the completion data from the LSPs
	sources = {
		{ name = 'nvim_lsp'},
		{ name = 'path'},
	},
})
-- setup multi-line editing plugin
--
-- open parent directory using in oil using '-'
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
--
require "lsp_signature".setup()

-- setup mason
require("mason").setup({})
require("mason-lspconfig").setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = {"rust_analyzer"},-- "gopls", "zls" },
})

local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({})
lspconfig.gopls.setup({})
lspconfig.zls.setup({})

-- mappings for diagnostics
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

local set = vim.opt
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- telescope config
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--
--
--
local mappings = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- keymappings to center searching to the center of the buffer
keymap("n", "n", "nzz", mappings)
keymap("n", "N", "Nzz", mappings)


-- configure treesitter
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'html', 'c', 'cpp', 'go', 'lua','rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)


set.clipboard = "unnamedplus"
set.showmode = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

-- search and replace
vim.opt.inccommand = "split"
set.incsearch = true
-- highlight all on search and remove highlight on escape
vim.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.signcolumn = "yes"

-- indentation
set.breakindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4

-- ergonomics
set.scrolloff = 3
set.cc = "80"
vim.opt.number = true
vim.opt.relativenumber = true

-- casing
set.ignorecase = true
set.smartcase = true

-- files
set.swapfile = false
set.undofile = true 



require("rose-pine").setup({
    dark_variant = "main", -- main, moon, or dawn
    styles = {
        bold = true,
        italic = true,
        transparency = false,
		comments = italic,
    }
})

vim.cmd [[colorscheme rose-pine]]
