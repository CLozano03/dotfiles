return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 15,
      direction = 'horizontal',
      auto_scroll = true,
      start_in_insert = true,
      shade_terminals = true,
      shade_factor = 1,
      persist_size = true,
      float_opts = {
        border = 'curved',
        winblend = 3,
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      local toggleterm = require 'toggleterm'

      vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })

      -- Change to normal mode in terminal
      vim.api.nvim_set_keymap('t', '<c-\\><c-n>', [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
  },
}
