-- [[ Basic Keymaps ]]
--
--  See `:help vim.keymap.set()`
local set_keymap = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
set_keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Execute current lua line
-- set_keymap('v', '<leader>xx', ':lua<CR>')
-- set_keymap('n', '<leader>xx', ':.lua<CR>')

-- Quickfix List
set_keymap('n', '<C-d>', '<Cmd>normal! <C-d>zz<CR>', { noremap = true, silent = true })
set_keymap('n', '<C-u>', '<Cmd>normal! <C-u>zz<CR>', { noremap = true, silent = true })

-- System clipboard
set_keymap({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
set_keymap({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
