return {
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
}
