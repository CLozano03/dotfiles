return {
   -- {
   --    -- To use ChatGPT in Neovim, you need to set up an API key from OpenAI.
   --    -- Follow these steps to get your API key:
   --    -- 1. Sign up or log in to your OpenAI account at https://platform
   --    -- .openai.com/.
   --    -- 2. Navigate to the API section and create a new API key.
   --    -- 3. Copy the generated API key and keep it secure.
   --    -- 4. Store the API key in a secure location, in this case, we are using
   --    --    a GPG-encrypted file at ~/secret.txt.gpg.
   --    -- 5. Now, you can use the ChatGPT plugin in Neovim, and it will
   --    --   retrieve the API key from the specified command.
   --    'jackMort/ChatGPT.nvim',
   --    event = 'VeryLazy',
   --    enabled = fasle,
   --    config = function()
   --       local home = vim.fn.expand '$HOME'
   --       require('chatgpt').setup {
   --          api_key_cmd = 'gpg --decrypt ' .. home .. '/secret.txt.gpg',
   --       }
   --    end,
   --    dependencies = {
   --       'MunifTanjim/nui.nvim',
   --       'nvim-lua/plenary.nvim',
   --       'folke/trouble.nvim', -- optional
   --       'nvim-telescope/telescope.nvim',
   --    },
   -- },
   {
      'CopilotC-Nvim/CopilotChat.nvim',
      disabled = true,
      keys = {
         { '<leader>caa', false },
         { '<leader>cax', false },
         { '<leader>caq', false },
         { '<leader>cap', false },
         { '<leader>cac', '', desc = '+copilotchat', mode = { 'n', 'v' } },
         {
            '<leader>cca',
            function()
               return require('CopilotChat').toggle()
            end,
            desc = 'Toggle (CopilotChat)',
            mode = { 'n', 'v' },
         },
         {
            '<leader>ccx',
            function()
               return require('CopilotChat').reset()
            end,
            desc = 'Clear (CopilotChat)',
            mode = { 'n', 'v' },
         },
         {
            '<leader>ccq',
            function()
               local input = vim.fn.input 'Quick Chat: '
               if input ~= '' then
                  require('CopilotChat').ask(input)
               end
            end,
            desc = 'Quick Chat (CopilotChat)',
            mode = { 'n', 'v' },
         },
         {
            '<leader>ccp',
            function()
               require('CopilotChat').select_prompt()
            end,
            desc = 'Prompt Actions (CopilotChat)',
            mode = { 'n', 'v' },
         },
      },
      opts = {
         model = 'gpt-4.1',
         show_help = false,
         auto_insert_mode = false,
         mappings = {
            reset = {
               normal = '<D-k>',
               insert = '<D-k>',
            },
         },
      },
   },
   {
      'github/copilot.vim',
      enabled = true,
      config = function()
         vim.g.copilot_is_enabled = true

         local function toggle_copilot_status()
            if vim.g.copilot_is_enabled then
               vim.cmd 'Copilot disable'
               print 'Copilot disabled'
               vim.g.copilot_is_enabled = false
            else
               vim.cmd 'Copilot enable'
               print 'Copilot enabled'
               vim.g.copilot_is_enabled = true
            end
         end

         vim.keymap.set('n', '<leader>cg', toggle_copilot_status, { desc = 'Toggle GitHub Copilot' })
      end,
   },
}
