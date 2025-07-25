-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dap-repl-[0-9]*',
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Wether to use `foldmethod=indent` for Python files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- use pep8 standards
    -- folds based on indentation https://neovim.io/doc/user/fold.html#fold-indent
    -- if you are a heavy user of folds, consider using `nvim-ufo`
    -- vim.opt_local.foldmethod = 'indent'
  end,
})

-- Set the default file type to `yaml` for `.yml.sample` files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.yml.sample',
  callback = function()
    vim.bo.filetype = 'yaml'
  end,
})

local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup 'autoupdate',
  callback = function()
    require('lazy').update {
      show = false,
    }
  end,
})

--Change automatically cwd when opens a dir
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local dir = vim.fn.argv(0)
    if dir and vim.fn.isdirectory(dir) == 1 then
      vim.cmd('cd ' .. dir)
    end
  end,
})
