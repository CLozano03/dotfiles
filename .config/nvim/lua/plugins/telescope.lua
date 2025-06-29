local telescope_builtin = require 'telescope.builtin'
return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {},
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
    keys = {
      { '<leader>sh', telescope_builtin.help_tags, desc = ' [S]earch [H]elp', 'n' },
      { '<leader>sk', telescope_builtin.keymaps, desc = ' [S]earch [K]eymaps', mode = 'n' },
      { '<leader>sf', telescope_builtin.find_files, desc = ' [S]earch [F]iles', mode = 'n' },
      { '<leader>ss', telescope_builtin.builtin, desc = ' [S]earch [S]elect Telescope', mode = 'n' },
      { '<leader>sw', telescope_builtin.grep_string, desc = ' [S]earch current [W]ord', mode = 'n' },
      { '<leader>sg', telescope_builtin.live_grep, desc = ' [S]earch by [G]rep', mode = 'n' },
      { '<leader>sd', telescope_builtin.diagnostics, desc = ' [S]earch [D]iagnostics', mode = 'n' },
      { '<leader>sr', telescope_builtin.resume, desc = ' [S]earch [R]esume', mode = 'n' },
      { '<leader>s.', telescope_builtin.oldfiles, desc = ' [S]earch Recent Files ("." for repeat)', mode = 'n' },
      { '<leader><leader>', telescope_builtin.buffers, desc = ' [ ] Find existing buffers', mode = 'n' },

      -- Shortcut for searching your Neovim configuration files
      {
        '<leader>sn',
        function()
          telescope_builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = ' [S]earch [N]eovim files',
        mode = 'n',
      },

      -- Slightly advanced example of overriding default behavior and theme
      {
        '<leader>/',
        function()
          -- You can pass additional configuration to Telescope to change the theme, layout, etc.
          telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = ' [/] Fuzzily search in current buffer',
        mode = 'n',
      },

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.require 'telescope.builtin'.live_grep()` for information about particular keys
      {
        '<leader>s/',
        function()
          telescope_builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        desc = ' [S]earch [/] in Open Files',
        mode = 'n',
      },
    },
  },
}
