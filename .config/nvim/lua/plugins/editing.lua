return {
   {
      'chrisgrieser/nvim-various-textobjs',
      ft = 'python',
      event = 'UIEnter',
      opts = { keymaps = { useDefaults = true } },
   },
   {
      'mbbill/undotree',
      event = 'VeryLazy',
      config = function()
         vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = ' Undotree toggle' })
      end,
   },
   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      dependencies = { 'hrsh7th/nvim-cmp' },
      config = function()
         require('nvim-autopairs').setup {}
         local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
         local cmp = require 'cmp'
         cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end,
   },
   { -- Collection of various small independent plugins/modules
      'echasnovski/mini.nvim',
      config = function()
         -- Better Around/Inside textobjects
         --
         -- Examples:
         --  - va)  - [V]isually select [A]round [)]paren
         --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
         --  - ci'  - [C]hange [I]nside [']quote
         require('mini.ai').setup { n_lines = 500 }

         -- Add/delete/replace surroundings (brackets, quotes, etc.)
         --
         -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
         -- - sd'   - [S]urround [D]elete [']quotes
         -- - sr)'  - [S]urround [R]eplace [)] [']
         require('mini.surround').setup()

         -- Simple and easy statusline.
         --  You could remove this setup call if you don't like it,
         --  and try some other statusline plugin
         local statusline = require 'mini.statusline'
         -- set use_icons to true if you have a Nerd Font
         statusline.setup { use_icons = vim.g.have_nerd_font }

         -- You can configure sections in the statusline by overriding their
         -- default behavior. For example, here we set the section for
         -- cursor location to LINE:COLUMN
         ---@diagnostic disable-next-line: duplicate-set-field
         statusline.section_location = function()
            return '%2l:%-2v'
         end
      end,
   },
   {
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
   },
}
