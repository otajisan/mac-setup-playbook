vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd nvim-treesitter]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use "projekt0n/github-nvim-theme"

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {'kevinhwang91/nvim-hlslens'}

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }

  use 'lambdalisue/fern.vim'
  use 'yuki-yano/fern-preview.vim'

  use({
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      run = ":TSUpdateSync",
  })

  use({
      "p00f/nvim-ts-rainbow",
      requires = "nvim-treesitter/nvim-treesitter",
      after = "nvim-treesitter",
  })

  use 'neovim/nvim-lspconfig'

  use {"ellisonleao/glow.nvim"}

end)