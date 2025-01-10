---@diagnostic disable: undefined-global
vim.g.mapleader = ' ' 
vim.g.maplocalleader = ' '
vim.opt.signcolumn = 'yes'
vim.shiftwidth = 4
vim.tabstop = 4
vim.swapfile = false
vim.opt.number = true 
vim.opt.relativenumber = true 
vim.opt.mouse = 'a'
vim.opt.cc = '80'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = 'split'
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)


local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
      'ibhagwan/fzf-lua',
      'VonHeikemen/lsp-zero.nvim',
      'neovim/nvim-lspconfig',
      'ellisonleao/gruvbox.nvim',
})


require("gruvbox").setup({
	  terminal_colors = true,
	  contrast = "hard",
})
vim.cmd.colorscheme "gruvbox"


-- Fuzzy finder
vim.api.nvim_set_keymap("n", "<leader>f", ":FzfLua files<CR>", {silent= true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":FzfLua grep<CR>", {noremap = true })
-- This gets rid of a git_status warning displayed by FZF-LUA for some odd reason
require('fzf-lua').setup({
	files = {
		git_icons = false,
		silent = true,
	},
})

-- LSP - Setup bare rust_analyzer, only used for DOCS and DIAGNOSTICS.
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.keymap.set({'n', 'x'}, '<C-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	vim.keymap.set('n', '<leader>m', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
	vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
	-- Mainly to close any floating window when in focus
	vim.keymap.set("n", "<C-[>", ':close<CR>', {noremap = true, silent = true})
  end,
})
-- setup rust-analyzer
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').zls.setup({})
