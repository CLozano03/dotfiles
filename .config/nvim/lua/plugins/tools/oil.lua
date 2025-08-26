return {
   'stevearc/oil.nvim',
   lazy = false,
   opts = {
      default_file_explorer = true,
      view_options = {
         show_hidden = true,
      },
      float = {
         padding = 2,
         max_width = 100,
         max_height = 30,
         border = 'rounded',
         win_options = {
            winblend = 0,
         },
      },

      use_default_keymaps = true,
      view = 'float',
      keymaps = {
         ['q'] = function()
            vim.cmd 'quit'
         end,
      },
   },
   keys = {
      { '-', '<cmd>Oil --float<CR>', mode = 'n', desc = 'Abrir Oil flotante' },
   },
}
