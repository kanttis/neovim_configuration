-- https://lsp-zero.netlify.app/v3.x/tutorial.html

-- lazyvim installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
	print('Done.')
end
vim.opt.rtp:prepend(lazypath)

-- add lazyvim plugins
require('lazy').setup({
	-- install colorscheme
	{'folke/tokyonight.nvim'},

	-- lsp-zero
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
	-- {'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' }},
	--
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
	},
})

-- lsp-zero configuration
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

-- some settings
local opts = { noremap = true, silent = true }
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufn)
	if client.server_capabilities.inlayHintProvider then
		vim.g.inlay_hints_visible = true
		vim.lsp.inlay_hint.enable(bufnr)
	else
		print("No inlay hints available")
	end
end
	
-- set up globally installed rust_analyzer
require('lspconfig').rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
	lsp_flags = lsp_flags,
})


-- set colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')

-- display relative line numbers
vim.opt.relativenumber = true

