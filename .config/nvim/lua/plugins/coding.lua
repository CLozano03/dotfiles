return {
   {
      'saghen/blink.cmp',
      -- dependencies = 'rafamadriz/friendly-snippets',
      version = 'v0.*',

      opts = {
         keymap = { preset = 'default' },
         appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
         },
         fuzzy = { implementation = 'prefer_rust_with_warning' },
      },
   },
   {

      -- Autoformat
      'stevearc/conform.nvim',
      event = { 'BufWritePre', 'BufNewFile' },
      cmd = { 'ConformInfo' },
      keys = {
         {
            '<leader>f',
            function()
               require('conform').format { async = true, lsp_format = 'fallback' }
            end,
            mode = 'n',
            desc = '[F]ormat buffer',
         },
      },
      opts = {
         notify_on_error = false,
         format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
               lsp_format_opt = 'never'
            else
               lsp_format_opt = 'fallback'
            end
            return {
               imeout_ms = 500,
               lsp_format = lsp_format_opt,
            }
         end,
         formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            zsh = { 'shfmt' },
         },
      },
   },
   { -- Linting
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
   },
   {
      'ThePrimeagen/refactoring.nvim',
      event = 'VeryLazy',
      dependencies = {
         'nvim-lua/plenary.nvim',
         'nvim-treesitter/nvim-treesitter',
      },
      config = function()
         require('refactoring').setup()
         vim.keymap.set('x', '<leader>re', ':Refactor extract ')
         vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ')

         vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ')

         vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var')

         vim.keymap.set('n', '<leader>rI', ':Refactor inline_func')

         vim.keymap.set('n', '<leader>rb', ':Refactor extract_block')
         vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file')
      end,
   },
   {
      'luckasRanarison/tailwind-tools.nvim',
      name = 'tailwind-tools',
      build = ':UpdateRemotePlugins',
      dependencies = {
         'nvim-treesitter/nvim-treesitter',
         'nvim-telescope/telescope.nvim',
         'neovim/nvim-lspconfig',
      },
      ft = { 'html', 'css', 'javascript', 'typescript' },
   },
   { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      main = 'nvim-treesitter.configs', -- Sets main module to use for opts
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      opts = {
         ensure_installed = {
            'bash',
            'c',
            'diff',
            'html',
            'css',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
            'python',
            'go',
            'javascript',
            'typescript',
            'java',
         },
         -- Autoinstall languages that are not installed
         auto_install = true,
         highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'ruby' },
         },
         indent = { enable = true, disable = { 'ruby' } },
      },
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
   },

   {
      'nvim-treesitter/nvim-treesitter-context',
   },
   {
      'IndianBoy42/tree-sitter-just',
   },
}
