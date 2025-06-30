return {
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  },
  {
    'Weyaaron/nvim-training',
    event = 'VeryLazy',
    pin = true,
  },
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },
  -- {
  --   'tris203/precognition.nvim',
  --   event = 'VeryLazy',
  --   opts = {},
  -- },
}
