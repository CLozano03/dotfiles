return {
   'folke/snacks.nvim',
   priority = 1000,
   lazy = false,
   ---@type snacks.Config
   opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      gitbrowse = { enabled = true },
      image = {},
      lazygit = { enabled = true },
      terminal = {
         enabled = true,
         reuse = true,
         win = {
            type = 'float',
            border = 'rounded',
            width = 100,
            height = 30,
            title = 'Terminal',
         },
      },

      scroll = {
         enabled = true,
         animate = {
            duration = { step = 15, total = 80 },
            easing = 'linear',
         },
      },
   },

   keys = function()
      local snacks = require 'snacks'
      return {
         {
            '<leader>cR',
            function()
               snacks.rename.rename_file()
            end,
            desc = 'Rename File',
         },
         {
            '<leader>gg',
            function()
               snacks.lazygit.open()
            end,
            desc = 'Open LazyGit',
         },
         {
            '<leader>tt',
            function()
               snacks.terminal.toggle()
            end,
            desc = 'Open terminal',
         },
         {
            '<leader>zz',
            function()
               require('snacks').zen()
            end,
            desc = 'Toggle Zen Mode',
         },
      }
   end,
}
