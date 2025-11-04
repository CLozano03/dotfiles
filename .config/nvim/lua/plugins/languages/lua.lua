return {
   {
      -- `lazydev` configures Lua LSP for your Neovim config
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
         library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
         },
      },
   },
}
