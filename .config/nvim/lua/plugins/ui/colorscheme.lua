return {
  {
    -- Colorscheme based on wallpaper colors
    'mbrea-c/wal-colors.nvim',
    config = function()
      vim.cmd [[colorscheme mbc]] -- activate the colorscheme
    end,
    priority = 1000, -- recommended to ensure the colorscheme
    -- is loaded before other plugins
  },

  -- { 'Mofiqul/vscode.nvim' },
  -- {
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like:
  --     -- vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'BufReadPre',
    enabled = true,
    config = function()
      require('nvim-highlight-colors').setup {
        render = 'background',
        enable_named_colors = true,
        enable_tailwind = true,
      }
    end,
  },
}
