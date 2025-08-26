return { -- Linting
   'mfussenegger/nvim-lint',
   event = { 'BufReadPre', 'BufNewFile' },
   config = function()
      local lint = require 'lint'

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('LintAutogroup', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
         group = lint_augroup,
         callback = function()
            lint.try_lint()
         end,
      })

      vim.keymap.set('n', '<leader>l', function()
         lint.try_lint()
      end, { desc = 'Trigger linting for current file' })
   end,
}
