return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function(_, opts)
    local harpoon = require 'harpoon'
    harpoon:setup(opts)

    local map = vim.keymap.set
    local list = harpoon:list()

    map('n', '<leader>a', function()
      list:add()
    end, { desc = 'Harpoon Add file' })
    map('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(list)
    end, { desc = 'Harpoon Menu' })
    map('n', '<A-h>', function()
      list:select(1)
    end, { desc = 'Harpoon 1' })
    map('n', '<A-j>', function()
      list:select(2)
    end, { desc = 'Harpoon 2' })
    map('n', '<A-k>', function()
      list:select(3)
    end, { desc = 'Harpoon 3' })
    map('n', '<A-l>', function()
      list:select(4)
    end, { desc = 'Harpoon 4' })
    map('n', '<C-p>', function()
      list:prev()
    end, { desc = 'Harpoon Prev' })
    map('n', '<C-n>', function()
      list:next()
    end, { desc = 'Harpoon Next' })
  end,
}
