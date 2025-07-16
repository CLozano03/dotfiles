return {
  {
    'Vigemus/iron.nvim',
    ft = 'python',
    event = 'VeryLazy',
    config = function()
      local iron = require 'iron.core'
      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = { command = { 'zsh' } },
            python = {
              command = { 'python' },
              format = require('iron.fts.common').bracketed_paste_python,
            },
          },
          repl_open_cmd = 'horizontal botright 15 split',
        },
        keymaps = {
          send_motion = '<space>xc',
          visual_send = '<space>xv',
          send_file = '<space>xf',
          send_line = '<space>xl',
          send_paragraph = '<space>xp',
          send_until_cursor = '<space>xu',
          cr = '<space>x<cr>',
          interrupt = '<space>x<space>',
          exit = '<space>xq',
        },
        highlight = { italic = true },
        ignore_blank_lines = true,
      }

      vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
      vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
      vim.keymap.set('n', '<space>xx', function()
        vim.cmd.normal ' xciN'
        vim.cmd.normal 'vaN'
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
      end, { noremap = true, silent = true })
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { ',v', '<cmd>VenvSelect<cr>' },
    },
  }
}
