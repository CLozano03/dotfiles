return {
   {
      'mbrea-c/wal-colors.nvim',
      config = function()
         local wal_cache = vim.fn.expand '~/.cache/wal'
         if vim.fn.isdirectory(wal_cache) == 1 then
            vim.cmd [[colorscheme mbc]] -- activate wal-colors
         else
            vim.cmd [[colorscheme tokyonight-night]] -- fallback to tokyonight
         end
      end,
      priority = 1000,
   },

   {
      'folke/tokyonight.nvim',
      lazy = true, -- don't load unless called
      -- init = function()
      --    vim.cmd.colorscheme 'tokyonight-night'
      -- end,
   },
}
