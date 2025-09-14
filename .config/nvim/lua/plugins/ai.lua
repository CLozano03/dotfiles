return {

   {
      -- To use ChatGPT in Neovim, you need to set up an API key from OpenAI.
      -- Follow these steps to get your API key:
      -- 1. Sign up or log in to your OpenAI account at https://platform
      -- .openai.com/.
      -- 2. Navigate to the API section and create a new API key.
      -- 3. Copy the generated API key and keep it secure.
      -- 4. Store the API key in a secure location, in this case, we are using
      --    a GPG-encrypted file at ~/secret.txt.gpg.
      -- 5. Now, you can use the ChatGPT plugin in Neovim, and it will
      --   retrieve the API key from the specified command.
      'jackMort/ChatGPT.nvim',
      event = 'VeryLazy',
      config = function()
         local home = vim.fn.expand '$HOME'
         require('chatgpt').setup {
            api_key_cmd = 'gpg --decrypt ' .. home .. '/secret.txt.gpg',
         }
      end,
      dependencies = {
         'MunifTanjim/nui.nvim',
         'nvim-lua/plenary.nvim',
         'folke/trouble.nvim', -- optional
         'nvim-telescope/telescope.nvim',
      },
   },

   -- {
   --   'CopilotC-Nvim/CopilotChat.nvim',
   --   dependencies = {
   --     { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
   --     { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
   --   },
   --   build = 'make tiktoken', -- Only on MacOS or Linux
   --   opts = {
   --     -- See Configuration section for options
   --   },
   --   -- See Commands section for default commands if you want to lazy load on them
   -- },
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
