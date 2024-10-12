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
})

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
	ensure_installed = { "rust_analyzer", "gopls", "zls" },
})

local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({})
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
set.scrolloff = 8
set.cc = "80"
vim.opt.number = true
vim.opt.relativenumber = true

-- casing
set.ignorecase = true
set.smartcase = true

-- files
set.swapfile = false

vim.cmd [[colorscheme gruvbox-material]]
