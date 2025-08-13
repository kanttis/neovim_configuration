return {
  'adam12/ruby-lsp.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('lspconfig').solargraph.setup {
      cmd = { "solargraph", "stdio" },
      filetypes = { "ruby" },
      root_dir = function()
        return vim.fn.finddir(".git", ".;")
      end,
      settings = {
        solargraph = {
          diagnostics = true,
          formatting = true,
          folding = true,
          completion = true,
        },
      },
    }
  end,
}
