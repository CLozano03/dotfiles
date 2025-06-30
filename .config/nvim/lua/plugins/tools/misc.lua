return {
  {
    'ellisonleao/dotenv.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = ':call mkdp#util#install()',
  },
  {
    'amitds1997/remote-nvim.nvim',
    version = '*', -- Pin to GitHub releases
    dependencies = {
      'nvim-lua/plenary.nvim', -- For standard functions
      'MunifTanjim/nui.nvim', -- To build the plugin UI
      'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
    },
    config = true,
  },
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    keys = {
      {
        'mistricky/codesnap.nvim',
        build = 'make',
        keys = {
          { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
          { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
        },
        opts = {
          has_breadcrumbs = false, -- display file path on top of the snap
          bg_theme = 'default',
          watermark = '',
        },
      },
    },
  },
}
