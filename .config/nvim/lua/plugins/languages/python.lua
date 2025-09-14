return {

   -- Debugging
   {
      'mfussenegger/nvim-dap-python',
      ft = 'python',
      dependencies = {
         'mfussenegger/nvim-dap',
         'rcarriga/nvim-dap-ui',
         'nvim-neotest/nvim-nio',
      },
      config = function(_, _)
         local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
         require('dap-python').setup(path)

         local get_python_path = function()
            local venv_path = os.getenv 'VIRTUAL_ENV'
            if venv_path then
               return venv_path .. '/bin/python'
            end

            return nil
         end

         local dap = require 'dap'

         local original_python_adapter = dap.adapters.python
         dap.adapters.python = function(callback, config)
            -- Your custom enrichment of the config
            local final_config = vim.deepcopy(config)

            -- Placeholder expansion for launch directives
            local placeholders = {
               ['${file}'] = function(_)
                  return vim.fn.expand '%:p'
               end,
               ['${fileBasename}'] = function(_)
                  return vim.fn.expand '%:t'
               end,
               ['${fileBasenameNoExtension}'] = function(_)
                  return vim.fn.fnamemodify(vim.fn.expand '%:t', ':r')
               end,
               ['${fileDirname}'] = function(_)
                  return vim.fn.expand '%:p:h'
               end,
               ['${fileExtname}'] = function(_)
                  return vim.fn.expand '%:e'
               end,
               ['${relativeFile}'] = function(_)
                  return vim.fn.expand '%:.'
               end,
               ['${relativeFileDirname}'] = function(_)
                  return vim.fn.fnamemodify(vim.fn.expand '%:.:h', ':r')
               end,
               ['${workspaceFolder}'] = function(_)
                  return vim.fn.getcwd()
               end,
               ['${workspaceFolderBasename}'] = function(_)
                  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
               end,
               ['${env:([%w_]+)}'] = function(match)
                  return os.getenv(match) or ''
               end,
            }

            if final_config.envFile then
               local filePath = final_config.envFile
               for key, fn in pairs(placeholders) do
                  filePath = filePath:gsub(key, fn)
               end

               for line in io.lines(filePath) do
                  local words = {}
                  for word in string.gmatch(line, '[^=]+') do
                     table.insert(words, word)
                  end
                  if not final_config.env then
                     final_config.env = {}
                  end
                  final_config.env[words[1]] = words[2]
               end
            end

            -- Call the original adapter function with the enriched config
            return original_python_adapter(callback, final_config)
         end

         table.insert(require('dap').configurations.python, {
            justMyCode = false,
            type = 'python',
            request = 'launch',
            name = 'Python Launch File: JustMyCode=false',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            pythonPath = get_python_path(),
         })
         table.insert(require('dap').configurations.python, {
            type = 'debugpy',
            request = 'attach',
            name = 'Remote Python: Attach manual',
            port = 5678,
            host = '127.0.0.1',
            mode = 'remote',
            localRoot = vim.fn.getcwd(),
            remoteRoot = vim.fn.getcwd(),
            cwd = vim.fn.getcwd(),
         })
         table.insert(require('dap').configurations.python, {
            type = 'debugpy',
            request = 'attach',
            name = 'Remote Python: Docker Attach manual',
            port = 5678,
            host = '127.0.0.1',
            mode = 'remote',
            cwd = vim.fn.getcwd(),
            pathMappings = {
               {
                  localRoot = function()
                     return vim.fn.input('Local code folder > ', vim.fn.getcwd(), 'file')
                  end,
                  remoteRoot = function()
                     return vim.fn.input('Container code folder > ', '/', 'file')
                  end,
               },
            },
         })
      end,
   },

   -- Optional LSP configuration for Python
   lsp = {
      pyright = {
         settings = {
            python = {
               analysis = {
                  typeCheckingMode = 'basic',
                  -- add other settings as needed
               },
            },
         },
         filetypes = { 'python' },
      },
      ruff = {
         capabilities = { hoverProvider = false },
         filetypes = { 'python' },
      },
   },

   {
      'jay-babu/mason-nvim-dap.nvim',
      opts = {
         ensure_installed = {
            'python',
            'debugpy',
         },
      },
   },

   {
      'linux-cultist/venv-selector.nvim',
      dependencies = {
         'nvim-tree/nvim-web-devicons',
         'neovim/nvim-lspconfig',
         'mfussenegger/nvim-dap',
         'mfussenegger/nvim-dap-python',
         'nvim-telescope/telescope.nvim',
      },
      keys = {
         { ',v', '<cmd>VenvSelect<cr>', desc = 'Seleccionar venv' },
      },
      opts = {
         name = 'venv',
         auto_refresh = true,
      },
   },

   {
      'Vigemus/iron.nvim',
      ft = 'python',
      event = 'VeryLazy',
      config = function()
         local iron = require 'iron.core'
         local python_cmd = (vim.fn.executable 'ipython' == 1) and { 'ipython' } or { 'python3' }

         iron.setup {
            config = {
               scratch_repl = true,
               repl_definition = {
                  sh = {
                     command = { 'zsh' },
                  },
                  python = {
                     command = python_cmd,
                     format = require('iron.fts.common').bracketed_paste_python,
                  },
               },
               repl_open_cmd = 'vertical botright 65 split',
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
            highlight = {
               italic = true,
            },
            ignore_blank_lines = true,
         }

         -- Basics Iron keymaps
         vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
         vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
         vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
         vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

         -- Execute cell and move to next cell
         local function execute_cell_and_next()
            local start_line = vim.fn.search('^# %%', 'bnW')
            if start_line == 0 then
               start_line = 1
            end
            local end_line = vim.fn.search('^# %%', 'nW')
            if end_line == 0 then
               end_line = vim.fn.line '$' + 1
            end

            local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line - 1, false)
            iron.send(nil, lines)

            if end_line <= vim.fn.line '$' then
               vim.fn.cursor(end_line, 1)
            end
         end

         -- Map funcion for executing cell and moving to next
         vim.keymap.set('n', '<space>xn', execute_cell_and_next, { noremap = true, silent = true, desc = 'Execute cell and go to next' })

         -- Execute current cell without moving
         vim.keymap.set('n', '<space>xx', function()
            local start_line = vim.fn.search('^# %%', 'bnW')
            if start_line == 0 then
               start_line = 1
            end
            local end_line = vim.fn.search('^# %%', 'nW')
            if end_line == 0 then
               end_line = vim.fn.line '$' + 1
            end
            local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line - 1, false)
            iron.send(nil, lines)
         end, { noremap = true, silent = true, desc = 'Execute current cell' })
      end,
   },
   {
      'GCBallesteros/jupytext.nvim',
      config = function()
         require('jupytext').setup {
            style = 'hydrogen',
            output_extension = 'auto',
            force_ft = nil,
            update_nb_on_save = true,
         }
      end,
   },
   {
      'preservim/vim-markdown',
      ft = 'markdown',
      config = function()
         vim.g.vim_markdown_folding_disabled = 1
         vim.g.vim_markdown_conceal = 0
         vim.g.vim_markdown_conceal_code_blocks = 0
      end,
   },
   {
      'mfussenegger/nvim-lint',
      ft = 'python', -- Only for Python files
      opts = {
         linters_by_ft = {
            python = { 'ruff' },
         },
      },
   },

   -- Formatting
   {
      'stevearc/conform.nvim',
      opts = { formatters_by_ft = {
         python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      } },
   },
}
