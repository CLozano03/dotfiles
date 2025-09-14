-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
   local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
   if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
         { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
         { out, 'WarningMsg' },
         { '\nPress any key to exit...' },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
   end
end
vim.opt.rtp:prepend(lazypath)

local spec = {
   { import = 'plugins.languages' },
   { import = 'plugins.editing' },
   { import = 'plugins.ui' },
   { import = 'plugins.tools' },
   { import = 'plugins.coding' },
   { import = 'plugins.lsp' },
}

-- Setup lazy.nvim
require('lazy').setup {
   { 'nvim-tree/nvim-web-devicons', lazy = true },
   spec = spec,
   install = { colorscheme = {} },
   checker = { enabled = true },
   change_detection = { notify = true },
   concurrency = 2,
   ui = {
      icons = {
         cmd = '⌘',
         config = '',
         event = '',
         ft = '',
         init = '',
         keys = '',
         plugin = '',
         runtime = '',
         require = '󰢱',
         source = '',
         start = '',
         task = '✔',
         lazy = '󰒲',
      },
   },
}
