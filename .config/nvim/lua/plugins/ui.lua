return {
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
   {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
         require('lualine').setup {
            options = {
               icons_enabled = true,
               component_separators = { left = '', right = '' },
               section_separators = { left = '', right = '' },
            },
         }
      end,
   },
   {
      'folke/which-key.nvim',
      event = 'VeryLazy',
      opts = {
         spec = {
            { '<leader>b', group = 'De[B]ug' },
            { '<leader>c', group = '[C]ode' },
            { '<leader>d', group = '[D]ocument' },
            { '<leader>h', group = 'Git [H]unk' },
            { '<leader>r', group = '[R]ename' },
            { '<leader>s', group = '[S]earch' },
            { '<leader>t', group = '[T]est' },
            { '<leader>w', group = '[W]orkspace' },
         },
         icons = {
            mappings = vim.g.have_nerd_font,
            keys = vim.g.have_nerd_font and {} or {
               Up = '<Up> ',
               Down = '<Down> ',
               Left = '<Left> ',
               Right = '<Right> ',
               C = '<C-…> ',
               M = '<M-…> ',
               D = '<D-…> ',
               S = '<S-…> ',
               CR = '<CR> ',
               Esc = '<Esc> ',
               ScrollWheelDown = '<ScrollWheelDown> ',
               ScrollWheelUp = '<ScrollWheelUp> ',
               NL = '<NL> ',
               BS = '<BS> ',
               Space = '<Space> ',
               Tab = '<Tab> ',
               F1 = '<F1>',
               F2 = '<F2>',
               F3 = '<F3>',
               F4 = '<F4>',
               F5 = '<F5>',
               F6 = '<F6>',
               F7 = '<F7>',
               F8 = '<F8>',
               F9 = '<F9>',
               F10 = '<F10>',
               F11 = '<F11>',
               F12 = '<F12>',
            },
         },
      },
   },
   {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
         local alpha = require 'alpha'
         local dashboard = require 'alpha.themes.dashboard'

         -- Banner ASCII
         dashboard.section.header.val = {
            -- '',
            -- '',
            '',
            [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
            [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
            [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
            [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
            [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
            [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
            -- '',
         }

         -- Botones
         dashboard.section.buttons.val = {
            dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
            dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('p', '  Find project', ':Telescope projects<CR>'),
            dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
            dashboard.button('t', '  Find text', ':Telescope live_grep<CR>'),
            dashboard.button('l', '󰒲 Lazy', ':Lazy<CR>'),
            dashboard.button('c', '  Nvim Config', ':Telescope find_files cwd=~/.config/nvim<CR>'),
            dashboard.button('q', '  Quit', ':qa<CR>'),
         }

         -- Footer with info
         local function footer()
            local stats = require('lazy').stats()
            return 'Loaded ' .. stats.count .. ' plugins in ' .. string.format('%.2f', stats.startuptime) .. 'ms'
         end
         dashboard.section.footer.val = footer
         dashboard.section.footer.opts.hl = 'Comment'

         -- Align center
         dashboard.opts.layout = {
            { type = 'padding', val = 4 },
            dashboard.section.header,
            { type = 'padding', val = 2 },
            dashboard.section.buttons,
            { type = 'padding', val = 1 },
            dashboard.section.footer,
         }

         alpha.setup(dashboard.opts)
      end,
   },
}
