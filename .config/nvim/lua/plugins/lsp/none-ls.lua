return {
  'nvimtools/none-ls.nvim',
  config = function()
    local nls = require 'null-ls'
    local b = nls.builtins

    nls.setup {
      debug = false,
      sources = {
        b.formatting.stylua,
      },
    }

    vim.keymap.set('n', '<leader>gf', function()
      vim.lsp.buf.format { async = true }
    end, { desc = 'Format with null-ls' })
  end,
}
