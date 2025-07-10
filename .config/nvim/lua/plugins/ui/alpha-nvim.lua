return {
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
}
