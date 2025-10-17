return {
   -- { 'bilal2453/luvit-meta', lazy = true }, -- Comentado como en el original
   {
      'williamboman/mason.nvim',
      dependencies = {
         'williamboman/mason-lspconfig.nvim',
         'whoissethdaniel/mason-tool-installer.nvim',
      },
      config = function()
         require('mason').setup {
            ui = {
               border = 'rounded',
               icons = {
                  package_installed = '✓',
                  package_pending = '➜',
                  package_uninstalled = '✗',
               },
            },
         }

         require('mason-lspconfig').setup {
            ensure_installed = {
               'lua_ls',
               'pyright',
               'html',
               'cssls',
               'bashls',
               'clangd',
            },
         }

         require('mason-tool-installer').setup {
            ensure_installed = {
               'stylua', -- lua formatter
               'ruff', -- python linter and formatter
               'eslint_d', -- javascript/ts linter
               'markdownlint', -- markdown linter
            },
         }
      end,
   },
   {
      -- Configuración principal de LSP
      'neovim/nvim-lspconfig',
      enabled = true,
      dependencies = {
         { 'williamboman/mason.nvim', config = true },
         'williamboman/mason-lspconfig.nvim',
         'whoissethdaniel/mason-tool-installer.nvim',
         'saghen/blink.cmp',
         { 'j-hui/fidget.nvim', opts = {} },
         'hrsh7th/cmp-nvim-lsp',
      },
      config = function()
         -- Configuración para Java si el plugin existe
         local plugin_name = 'java'
         local java_plugin_exists = require('lazy.core.config').plugins[plugin_name] ~= nil
         if java_plugin_exists then
            require('java').setup {
               root_markers = {
                  'settings.gradle',
                  'settings.gradle.kts',
                  'pom.xml',
                  'build.gradle',
                  'mvnw',
                  'gradlew',
                  'build.gradle.kts',
               },
            }
         end

         -- Autocomando para configurar los atajos de teclado cuando un LSP se adjunta a un buffer
         vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
               local map = function(keys, func, desc, mode)
                  mode = mode or 'n'
                  vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
               end

               map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
               map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
               map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
               map('<leader>d', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
               map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
               map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
               map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
               map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'v' })

               -- Resaltar referencias del símbolo bajo el cursor
               local client = vim.lsp.get_client_by_id(event.data.client_id)
               if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                  local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                     buffer = event.buf,
                     group = highlight_augroup,
                     callback = vim.lsp.buf.document_highlight,
                  })
                  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                     buffer = event.buf,
                     group = highlight_augroup,
                     callback = vim.lsp.buf.clear_references,
                  })
                  vim.api.nvim_create_autocmd('LspDetach', {
                     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                     callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                     end,
                  })
               end

               -- Activar/desactivar inlay hints
               if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                  map('<leader>th', function()
                     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                  end, '[T]oggle Inlay [H]ints')
               end
            end,
         })

         -- Crear las capabilities del cliente LSP y extenderlas con las de nvim-cmp
         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

         -- Tabla de servidores con configuraciones personalizadas
         local servers = {
            shfmt = {},
            -- Aquí puedes añadir configuraciones específicas para otros servidores si lo necesitas
            -- Ejemplo:
            -- lua_ls = {
            --   settings = {
            --     Lua = {
            --       runtime = { version = 'LuaJIT' },
            --       diagnostics = { globals = {'vim'} },
            --     },
            --   },
            -- },
         }

         -- Cargar configuraciones de LSP desde la carpeta 'plugins/languages'
         local languages_path = vim.fn.stdpath 'config' .. '/lua/plugins/languages'
         local scan = vim.loop.fs_scandir(languages_path)
         if scan then
            while true do
               local name, type = vim.loop.fs_scandir_next(scan)
               if not name then
                  break
               end
               if name:sub(-4) == '.lua' then
                  local module_name = 'plugins.languages.' .. name:sub(1, -5)
                  local ok, lang_config = pcall(require, module_name)
                  if ok and lang_config.lsp then
                     servers = vim.tbl_extend('force', servers, lang_config.lsp)
                  end
               end
            end
         end

         -- Configurar mason-lspconfig para que use la nueva API de vim.lsp.config
         require('mason-lspconfig').setup {
            handlers = {
               function(server_name)
                  local server = servers[server_name] or {}

                  -- Lógica personalizada para ruff
                  if server_name == 'ruff' then
                     local ruff_config_path = vim.loop.os_homedir() .. '/.config/ruff/ruff.toml'
                     local project_ruff_config = vim.loop.cwd() .. '/ruff.toml'
                     local f = io.open(project_ruff_config, 'r')
                     if f ~= nil then
                        io.close(f)
                        ruff_config_path = project_ruff_config
                     end
                     local init_options = {
                        settings = {
                           format = { args = { '--config=' .. ruff_config_path } },
                           lint = { args = { '--config=' .. ruff_config_path } },
                        },
                     }
                     server.init_options = vim.tbl_deep_extend('force', {}, init_options, server.init_options or {})
                  end

                  -- Fusionar capabilities globales con las específicas del servidor
                  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

                  -- ✨ EL CAMBIO CLAVE ESTÁ AQUÍ ✨
                  -- Usar la nueva API vim.lsp.config en lugar de require('lspconfig')
                  vim.lsp.config[server_name].setup(server)
               end,
            },
         }
      end,
   },
}
