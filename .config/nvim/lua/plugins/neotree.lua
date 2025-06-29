return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false, -- cargarlo desde el inicio
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- iconos bonitos
    'MunifTanjim/nui.nvim',
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      filtered_items = {
        visible = true, -- muestra archivos ocultos por defecto
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    window = {
      mappings = {
        ['<space>'] = 'none',
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<cr>'] = 'open',
        ['o'] = 'open',
        ['a'] = 'add',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['q'] = 'close_window',
        ['?'] = 'show_help',
      },
    },
  },
  keys = {
    {
      '<leader>ef',
      '<cmd>Neotree focus<cr>',
      desc = 'Focus Neo-tree (filesystem)',
    },
    {
      '<leader>eb',
      '<cmd>Neotree buffers toggle<cr>',
      desc = 'Buffers',
    },
    {
      '<leader>eg',
      '<cmd>Neotree git_status toggle<cr>',
      desc = 'Git status',
    },
    {
      '<leader>et',
      '<cmd>Neotree toggle<cr>',
      desc = 'Toggle Neo-tree',
    },
  },
  -- enabled = false,
}
