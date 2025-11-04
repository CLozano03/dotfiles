return {
   {
      'mfussenegger/nvim-dap',
      dependencies = {

         {
            'rcarriga/nvim-dap-ui',
            opts = {
               icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
               controls = {
                  icons = {
                     pause = '⏸',
                     play = '▶',
                     step_into = '⏎',
                     step_over = '⏭',
                     step_out = '⏮',
                     step_back = 'b',
                     run_last = '▶▶',
                     terminate = '⏹',
                     disconnect = '⏏',
                  },
               },
               layouts = {
                  {
                     elements = {
                        { id = 'stacks', size = 0.3 },
                        { id = 'breakpoints', size = 0.1 },
                        { id = 'scopes', size = 0.3 },
                        { id = 'watches', size = 0.2 },
                     },
                     position = 'right',
                     size = 40,
                  },
                  {
                     elements = {
                        { id = 'repl', size = 1.0 },
                     },
                     position = 'bottom',
                     size = 5,
                  },
               },
            },
         },
         'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui

         -- Installs the debug adapters for you
         'williamboman/mason.nvim',
         'jay-babu/mason-nvim-dap.nvim',
         'theHamsta/nvim-dap-virtual-text',

         -- Add your own debuggers here
         'mfussenegger/nvim-dap-python',
      },

      config = function()
         local dap = require 'dap'
         local dapui = require 'dapui'
         local dap_python = require 'dap-python'

         require('dapui').setup {}
         require('nvim-dap-virtual-text').setup {
            commented = true, -- Show virtual text alongside comment
         }

         dap_python.setup 'python3'

         vim.fn.sign_define('DapBreakpoint', {
            text = '',
            texthl = 'DiagnosticSignError',
            linehl = '',
            numhl = '',
         })

         vim.fn.sign_define('DapBreakpointRejected', {
            text = '', -- or "❌"
            texthl = 'DiagnosticSignError',
            linehl = '',
            numhl = '',
         })

         vim.fn.sign_define('DapStopped', {
            text = '', -- or "→"
            texthl = 'DiagnosticSignWarn',
            linehl = 'Visual',
            numhl = 'DiagnosticSignWarn',
         })

         -- Automatically open/close DAP UI
         dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
         end

         local opts = { noremap = true, silent = true }

         -- Toggle breakpoint
         vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, vim.tbl_extend('force', opts, { desc = 'Toggle breakpoint' }))
         vim.keymap.set('n', '<leader>dc', dap.continue, vim.tbl_extend('force', opts, { desc = 'Continue/Start' }))
         -- vim.keymap.set('n', '<C-l>', dap.step_over, vim.tbl_extend('force', opts, { desc = 'Step over' }))
         vim.keymap.set('n', '<leader>di', dap.step_into, vim.tbl_extend('force', opts, { desc = 'Step into' }))
         vim.keymap.set('n', '<leader>dO', dap.step_out, vim.tbl_extend('force', opts, { desc = 'Step out' }))
         vim.keymap.set('n', '<leader>dq', function()
            dap.terminate()
            dap.disconnect()
         end, vim.tbl_extend('force', opts, { desc = 'Terminate' }))
         vim.keymap.set('n', '<leader>du', dapui.toggle, vim.tbl_extend('force', opts, { desc = 'Toggle UI' }))
         vim.keymap.set('n', '<leader>dr', function()
            if dap.session() then
               dap.restart()
            else
               dap.run_last()
            end
         end, vim.tbl_extend('force', opts, { desc = 'Restart session' }))
      end,
   },
   --
   -- {
   --    'mfussenegger/nvim-dap-python',
   --    ft = 'python',
   --    dependencies = {
   --       'mfussenegger/nvim-dap',
   --       'rcarriga/nvim-dap-ui',
   --       'nvim-neotest/nvim-nio',
   --    },
   --    config = function(_, _)
   --       local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
   --       require('dap-python').setup(path)
   --
   --       local get_python_path = function()
   --          local venv_path = os.getenv 'VIRTUAL_ENV'
   --          if venv_path then
   --             return venv_path .. '/bin/python'
   --          end
   --
   --          return nil
   --       end
   --
   --       local dap = require 'dap'
   --
   --       local original_python_adapter = dap.adapters.python
   --       dap.adapters.python = function(callback, config)
   --          -- Your custom enrichment of the config
   --          local final_config = vim.deepcopy(config)
   --
   --          -- Placeholder expansion for launch directives
   --          local placeholders = {
   --             ['${file}'] = function(_)
   --                return vim.fn.expand '%:p'
   --             end,
   --             ['${fileBasename}'] = function(_)
   --                return vim.fn.expand '%:t'
   --             end,
   --             ['${fileBasenameNoExtension}'] = function(_)
   --                return vim.fn.fnamemodify(vim.fn.expand '%:t', ':r')
   --             end,
   --             ['${fileDirname}'] = function(_)
   --                return vim.fn.expand '%:p:h'
   --             end,
   --             ['${fileExtname}'] = function(_)
   --                return vim.fn.expand '%:e'
   --             end,
   --             ['${relativeFile}'] = function(_)
   --                return vim.fn.expand '%:.'
   --             end,
   --             ['${relativeFileDirname}'] = function(_)
   --                return vim.fn.fnamemodify(vim.fn.expand '%:.:h', ':r')
   --             end,
   --             ['${workspaceFolder}'] = function(_)
   --                return vim.fn.getcwd()
   --             end,
   --             ['${workspaceFolderBasename}'] = function(_)
   --                return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
   --             end,
   --             ['${env:([%w_]+)}'] = function(match)
   --                return os.getenv(match) or ''
   --             end,
   --          }
   --
   --          if final_config.envFile then
   --             local filePath = final_config.envFile
   --             for key, fn in pairs(placeholders) do
   --                filePath = filePath:gsub(key, fn)
   --             end
   --
   --             for line in io.lines(filePath) do
   --                local words = {}
   --                for word in string.gmatch(line, '[^=]+') do
   --                   table.insert(words, word)
   --                end
   --                if not final_config.env then
   --                   final_config.env = {}
   --                end
   --                final_config.env[words[1]] = words[2]
   --             end
   --          end
   --
   --          -- Call the original adapter function with the enriched config
   --          return original_python_adapter(callback, final_config)
   --       end
   --
   --       table.insert(require('dap').configurations.python, {
   --          justMyCode = false,
   --          type = 'python',
   --          request = 'launch',
   --          name = 'Python Launch File: JustMyCode=false',
   --          program = '${file}',
   --          cwd = vim.fn.getcwd(),
   --          pythonPath = get_python_path(),
   --       })
   --       table.insert(require('dap').configurations.python, {
   --          type = 'debugpy',
   --          request = 'attach',
   --          name = 'Remote Python: Attach manual',
   --          port = 5678,
   --          host = '127.0.0.1',
   --          mode = 'remote',
   --          localRoot = vim.fn.getcwd(),
   --          remoteRoot = vim.fn.getcwd(),
   --          cwd = vim.fn.getcwd(),
   --       })
   --       table.insert(require('dap').configurations.python, {
   --          type = 'debugpy',
   --          request = 'attach',
   --          name = 'Remote Python: Docker Attach manual',
   --          port = 5678,
   --          host = '127.0.0.1',
   --          mode = 'remote',
   --          cwd = vim.fn.getcwd(),
   --          pathMappings = {
   --             {
   --                localRoot = function()
   --                   return vim.fn.input('Local code folder > ', vim.fn.getcwd(), 'file')
   --                end,
   --                remoteRoot = function()
   --                   return vim.fn.input('Container code folder > ', '/', 'file')
   --                end,
   --             },
   --          },
   --       })
   --    end,
   -- },
}
