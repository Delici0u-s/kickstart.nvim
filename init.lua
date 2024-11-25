-- Finish Neotree Ini Bas 1
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    'MunifTanjim/nui.nvim',
    event = 'VeryLazy', -- or set up appropriate lazy loading
  },

  -- Other plugins
  'tpope/vim-sleuth',
  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd 'colorscheme kanagawa-dragon'
    end,
  },
  { 'nvim-neotest/nvim-nio' },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup { icons = { expanded = '▾', collapsed = '▸', current_frame = '★' } }
      require('dap-go').setup()

      -- Configure C++ adapter for `cppdbg`
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = 'C:/Users/maxib/.vscode/extensions/ms-vscode.cpptools-1.22.11-win32-x64/debugAdapters/bin/OpenDebugAD7.exe',
        options = { detached = false },
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'Enable pretty-printing',
              ignoreFailures = false,
            },
          },
        },
      }

      -- Keybindings and UI setup (same as before)
      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)
      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F13>', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },

  -- Remaining plugins
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
          require('window-picker').setup {
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          }
        end,
      },
    },
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      require('neo-tree').setup {
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil, -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '🗀 ',
            folder_open = '↳',
            folder_empty = '🗁 ',
            provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
              if node.type == 'file' or node.type == 'terminal' then
                local success, web_devicons = pcall(require, 'nvim-web-devicons')
                local name = node.type == 'terminal' and 'terminal' or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = devicon or icon.text
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = '*',
            highlight = 'NeoTreeFileIcon',
          },
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              -- Change type
              added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = '✖', -- this can only be used in the git_status source
              renamed = '󰁕', -- this can only be used in the git_status source
              -- Status type
              untracked = '',
              ignored = '',
              unstaged = '󰄱',
              staged = '',
              conflict = '',
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = 'left',
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
            ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
            -- Read `# Preview Mode` for more information
            ['l'] = 'focus_preview',
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ['t'] = 'open_tabnew',
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ['w'] = 'open_with_window_picker',
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ['C'] = 'close_node',
            -- ['C'] = 'close_all_subnodes',
            ['z'] = 'close_all_nodes',
            --["Z"] = "expand_all_nodes",
            ['a'] = {
              'add',
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = 'none', -- "none", "relative", "absolute"
              },
            },
            ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ['q'] = 'close_window',
            ['R'] = 'refresh',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
            ['i'] = 'show_file_details',
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            always_show_by_pattern = { -- uses glob style patterns
              --".env*",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['D'] = 'fuzzy_finder_directory',
              ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ['f'] = 'filter_on_submit',
              ['<c-x>'] = 'clear_filter',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['og'] = { 'order_by_git_status', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
              -- ['<key>'] = function(state) ... end,
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ['<down>'] = 'move_cursor_down',
              ['<C-n>'] = 'move_cursor_down',
              ['<up>'] = 'move_cursor_up',
              ['<C-p>'] = 'move_cursor_up',
              -- ['<key>'] = function(state, scroll_padding) ... end,
            },
          },

          commands = {}, -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ['bd'] = 'buffer_delete',
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
            },
          },
        },
        git_status = {
          window = {
            position = 'float',
            mappings = {
              ['A'] = 'git_add_all',
              ['gu'] = 'git_unstage_file',
              ['ga'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['gc'] = 'git_commit',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
              ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
              ['oc'] = { 'order_by_created', nowait = false },
              ['od'] = { 'order_by_diagnostics', nowait = false },
              ['om'] = { 'order_by_modified', nowait = false },
              ['on'] = { 'order_by_name', nowait = false },
              ['os'] = { 'order_by_size', nowait = false },
              ['ot'] = { 'order_by_type', nowait = false },
            },
          },
        },
      }

      vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
    end,
  },
  -- end of Neotree Plug

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

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
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  ------- BALLS
  -- commented out bcs own{
  -- commented out bcs own  -- Main LSP Configuration
  -- commented out bcs own  'neovim/nvim-lspconfig',
  -- commented out bcs own  dependencies = {
  -- commented out bcs own    -- Automatically install LSPs and related tools to stdpath for Neovim
  -- commented out bcs own    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
  -- commented out bcs own    'williamboman/mason-lspconfig.nvim',
  -- commented out bcs own    'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- commented out bcs own    -- Useful status updates for LSP.
  -- commented out bcs own    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  -- commented out bcs own    { 'j-hui/fidget.nvim', opts = {} },

  -- commented out bcs own    -- Allows extra capabilities provided by nvim-cmp
  -- commented out bcs own    'hrsh7th/cmp-nvim-lsp',
  -- commented out bcs own  },
  -- commented out bcs own  config = function()
  -- commented out bcs own    -- Brief aside: **What is LSP?**
  -- commented out bcs own    --
  -- commented out bcs own    -- LSP is an initialism you've probably heard, but might not understand what it is.
  -- commented out bcs own    --
  -- commented out bcs own    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- commented out bcs own    -- and language tooling communicate in a standardized fashion.
  -- commented out bcs own    --
  -- commented out bcs own    -- In general, you have a "server" which is some tool built to understand a particular
  -- commented out bcs own    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- commented out bcs own    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- commented out bcs own    -- processes that communicate with some "client" - in this case, Neovim!
  -- commented out bcs own    --
  -- commented out bcs own    -- LSP provides Neovim with features like:
  -- commented out bcs own    --  - Go to definition
  -- commented out bcs own    --  - Find references
  -- commented out bcs own    --  - Autocompletion
  -- commented out bcs own    --  - Symbol Search
  -- commented out bcs own    --  - and more!
  -- commented out bcs own    --
  -- commented out bcs own    -- Thus, Language Servers are external tools that must be installed separately from
  -- commented out bcs own    -- Neovim. This is where `mason` and related plugins come into play.
  -- commented out bcs own    --
  -- commented out bcs own    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- commented out bcs own    -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- commented out bcs own    --  This function gets run when an LSP attaches to a particular buffer.
  -- commented out bcs own    --    That is to say, every time a new file is opened that is associated with
  -- commented out bcs own    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  -- commented out bcs own    --    function will be executed to configure the current buffer
  -- commented out bcs own    vim.api.nvim_create_autocmd('LspAttach', {
  -- commented out bcs own      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  -- commented out bcs own      callback = function(event)
  -- commented out bcs own        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  -- commented out bcs own        -- to define small helper and utility functions so you don't have to repeat yourself.
  -- commented out bcs own        --
  -- commented out bcs own        -- In this case, we create a function that lets us more easily define mappings specific
  -- commented out bcs own        -- for LSP related items. It sets the mode, buffer and description for us each time.
  -- commented out bcs own        local map = function(keys, func, desc, mode)
  -- commented out bcs own          mode = mode or 'n'
  -- commented out bcs own          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  -- commented out bcs own        end

  -- commented out bcs own        -- Jump to the definition of the word under your cursor.
  -- commented out bcs own        --  This is where a variable was first declared, or where a function is defined, etc.
  -- commented out bcs own        --  To jump back, press <C-t>.
  -- commented out bcs own        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- commented out bcs own        -- Find references for the word under your cursor.
  -- commented out bcs own        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- commented out bcs own        -- Jump to the implementation of the word under your cursor.
  -- commented out bcs own        --  Useful when your language has ways of declaring types without an actual implementation.
  -- commented out bcs own        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- commented out bcs own        -- Jump to the type of the word under your cursor.
  -- commented out bcs own        --  Useful when you're not sure what type a variable is and you want to see
  -- commented out bcs own        --  the definition of its *type*, not where it was *defined*.
  -- commented out bcs own        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

  -- commented out bcs own        -- Fuzzy find all the symbols in your current document.
  -- commented out bcs own        --  Symbols are things like variables, functions, types, etc.
  -- commented out bcs own        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

  -- commented out bcs own        -- Fuzzy find all the symbols in your current workspace.
  -- commented out bcs own        --  Similar to document symbols, except searches over your entire project.
  -- commented out bcs own        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- commented out bcs own        -- Rename the variable under your cursor.
  -- commented out bcs own        --  Most Language Servers support renaming across files, etc.
  -- commented out bcs own        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  -- commented out bcs own        -- Execute a code action, usually your cursor needs to be on top of an error
  -- commented out bcs own        -- or a suggestion from your LSP for this to activate.
  -- commented out bcs own        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

  -- commented out bcs own        -- WARN: This is not Goto Definition, this is Goto Declaration.
  -- commented out bcs own        --  For example, in C this would take you to the header.
  -- commented out bcs own        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- commented out bcs own        -- The following two autocommands are used to highlight references of the
  -- commented out bcs own        -- word under your cursor when your cursor rests there for a little while.
  -- commented out bcs own        --    See `:help CursorHold` for information about when this is executed
  -- commented out bcs own        --
  -- commented out bcs own        -- When you move your cursor, the highlights will be cleared (the second autocommand).
  -- commented out bcs own        local client = vim.lsp.get_client_by_id(event.data.client_id)
  -- commented out bcs own        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
  -- commented out bcs own          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  -- commented out bcs own          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  -- commented out bcs own            buffer = event.buf,
  -- commented out bcs own            group = highlight_augroup,
  -- commented out bcs own            callback = vim.lsp.buf.document_highlight,
  -- commented out bcs own          })

  -- commented out bcs own          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  -- commented out bcs own            buffer = event.buf,
  -- commented out bcs own            group = highlight_augroup,
  -- commented out bcs own            callback = vim.lsp.buf.clear_references,
  -- commented out bcs own          })

  -- commented out bcs own          vim.api.nvim_create_autocmd('LspDetach', {
  -- commented out bcs own            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
  -- commented out bcs own            callback = function(event2)
  -- commented out bcs own              vim.lsp.buf.clear_references()
  -- commented out bcs own              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
  -- commented out bcs own            end,
  -- commented out bcs own          })
  -- commented out bcs own        end

  -- commented out bcs own        -- The following code creates a keymap to toggle inlay hints in your
  -- commented out bcs own        -- code, if the language server you are using supports them
  -- commented out bcs own        --
  -- commented out bcs own        -- This may be unwanted, since they displace some of your code
  -- commented out bcs own        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
  -- commented out bcs own          map('<leader>th', function()
  -- commented out bcs own            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  -- commented out bcs own          end, '[T]oggle Inlay [H]ints')
  -- commented out bcs own        end
  -- commented out bcs own      end,
  -- commented out bcs own    })

  -- commented out bcs own    -- Change diagnostic symbols in the sign column (gutter)
  -- commented out bcs own    -- if vim.g.have_nerd_font then
  -- commented out bcs own    --   local signs = { Error = '', Warn = '', Hint = '', Info = '' }
  -- commented out bcs own    --   for type, icon in pairs(signs) do
  -- commented out bcs own    --     local hl = 'DiagnosticSign' .. type
  -- commented out bcs own    --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  -- commented out bcs own    --   end
  -- commented out bcs own    -- end

  -- commented out bcs own    -- LSP servers and clients are able to communicate to each other what features they support.
  -- commented out bcs own    --  By default, Neovim doesn't support everything that is in the LSP specification.
  -- commented out bcs own    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  -- commented out bcs own    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  -- commented out bcs own    local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- commented out bcs own    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  -- commented out bcs own    -- Enable the following language servers
  -- commented out bcs own    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  -- commented out bcs own    --
  -- commented out bcs own    --  Add any additional override configuration in the following tables. Available keys are:
  -- commented out bcs own    --  - cmd (table): Override the default command used to start the server
  -- commented out bcs own    --  - filetypes (table): Override the default list of associated filetypes for the server
  -- commented out bcs own    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
  -- commented out bcs own    --  - settings (table): Override the default settings passed when initializing the server.
  -- commented out bcs own    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
  -- commented out bcs own    local servers = {
  -- commented out bcs own      -- clangd = {},
  -- commented out bcs own      -- gopls = {},
  -- commented out bcs own      -- pyright = {},
  -- commented out bcs own      -- rust_analyzer = {},
  -- commented out bcs own      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  -- commented out bcs own      --
  -- commented out bcs own      -- Some languages (like typescript) have entire language plugins that can be useful:
  -- commented out bcs own      --    https://github.com/pmizio/typescript-tools.nvim
  -- commented out bcs own      --
  -- commented out bcs own      -- But for many setups, the LSP (`ts_ls`) will work just fine
  -- commented out bcs own      -- ts_ls = {},
  -- commented out bcs own      --

  -- commented out bcs own      lua_ls = {
  -- commented out bcs own        -- cmd = {...},
  -- commented out bcs own        -- filetypes = { ...},
  -- commented out bcs own        -- capabilities = {},
  -- commented out bcs own        settings = {
  -- commented out bcs own          Lua = {
  -- commented out bcs own            completion = {
  -- commented out bcs own              callSnippet = 'Replace',
  -- commented out bcs own            },
  -- commented out bcs own            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
  -- commented out bcs own            -- diagnostics = { disable = { 'missing-fields' } },
  -- commented out bcs own          },
  -- commented out bcs own        },
  -- commented out bcs own      },
  -- commented out bcs own    }

  -- commented out bcs own    -- Ensure the servers and tools above are installed
  -- commented out bcs own    --  To check the current status of installed tools and/or manually install
  -- commented out bcs own    --  other tools, you can run
  -- commented out bcs own    --    :Mason
  -- commented out bcs own    --
  -- commented out bcs own    --  You can press `g?` for help in this menu.
  -- commented out bcs own    require('mason').setup()

  -- commented out bcs own    -- You can add other tools here that you want Mason to install
  -- commented out bcs own    -- for you, so that they are available from within Neovim.
  -- commented out bcs own    local ensure_installed = vim.tbl_keys(servers or {})
  -- commented out bcs own    vim.list_extend(ensure_installed, {
  -- commented out bcs own      'stylua', -- Used to format Lua code
  -- commented out bcs own    })
  -- commented out bcs own    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- commented out bcs own    require('mason-lspconfig').setup {
  -- commented out bcs own      handlers = {
  -- commented out bcs own        function(server_name)
  -- commented out bcs own          local server = servers[server_name] or {}
  -- commented out bcs own          -- This handles overriding only values explicitly passed
  -- commented out bcs own          -- by the server configuration above. Useful when disabling
  -- commented out bcs own          -- certain features of an LSP (for example, turning off formatting for ts_ls)
  -- commented out bcs own          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  -- commented out bcs own          require('lspconfig')[server_name].setup(server)
  -- commented out bcs own        end,
  -- commented out bcs own      },
  -- commented out bcs own    }
  -- commented out bcs own  end,
  -- commented out bcs own},
  -- The own:
  -- LSP configurations for Neovim
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Add LSP setup here if needed, or configure LSP servers later in the script.
    end,
  },

  -- Autocompletion plugins
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        }),
      }

      -- Cmdline setup for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Cmdline setup for `:`
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },

  -- Snippet plugins for vsnip (uncomment others if needed)
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  -- 'L3MON4D3/LuaSnip',
  -- 'saadparwaiz1/cmp_luasnip',
  -- 'SirVer/ultisnips',
  -- 'quangnguyen30192/cmp-nvim-ultisnips',
  -- 'dcampos/nvim-snippy',
  -- 'dcampos/cmp-snippy',

  -- Optional git completion
  -- 'petertriho/cmp-git',

  -- Add this to your lazy.nvim setup
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          -- Core languages
          'pyright', -- Python
          -- 'typescript-language-server', -- JavaScript/TypeScript
          -- 'lua-language-server', -- Lua
          'html', -- HTML
          -- 'css-lsp', -- CSS

          -- Additional languages
          -- 'matlab_ls', -- MATLAB
          'hdl_checker', -- VHDL
          -- 'clangd', -- C/C++
          -- 'jdtls', -- Java
          -- 'sqlls', -- SQL

          -- Popular tools and additional languages
          -- 'bashls', -- Bash/Shell
          'dockerls', -- Docker
          -- 'jsonls', -- JSON
          -- 'yamlls', -- YAML
          'marksman', -- Markdown
          -- 'vimls', -- VimScript
        },
        automatic_installation = true,
      }
    end,
  },

  -- end The own
  -- end The own
  -- end The own
  -- end The own
  -- end The own

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
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
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- Commented out bcus own { -- Autocompletion
  -- Commented out bcus own   'hrsh7th/nvim-cmp',
  -- Commented out bcus own   event = 'InsertEnter',
  -- Commented out bcus own   dependencies = {
  -- Commented out bcus own     -- Snippet Engine & its associated nvim-cmp source
  -- Commented out bcus own     {
  -- Commented out bcus own       'L3MON4D3/LuaSnip',
  -- Commented out bcus own       build = (function()
  -- Commented out bcus own         -- Build Step is needed for regex support in snippets.
  -- Commented out bcus own         -- This step is not supported in many windows environments.
  -- Commented out bcus own         -- Remove the below condition to re-enable on windows.
  -- Commented out bcus own         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
  -- Commented out bcus own           return
  -- Commented out bcus own         end
  -- Commented out bcus own         return 'make install_jsregexp'
  -- Commented out bcus own       end)(),
  -- Commented out bcus own       dependencies = {
  -- Commented out bcus own         -- `friendly-snippets` contains a variety of premade snippets.
  -- Commented out bcus own         --    See the README about individual language/framework/plugin snippets:
  -- Commented out bcus own         --    https://github.com/rafamadriz/friendly-snippets
  -- Commented out bcus own         -- {
  -- Commented out bcus own         --   'rafamadriz/friendly-snippets',
  -- Commented out bcus own         --   config = function()
  -- Commented out bcus own         --     require('luasnip.loaders.from_vscode').lazy_load()
  -- Commented out bcus own         --   end,
  -- Commented out bcus own         -- },
  -- Commented out bcus own       },
  -- Commented out bcus own     },
  -- Commented out bcus own     'saadparwaiz1/cmp_luasnip',

  -- Commented out bcus own     -- Adds other completion capabilities.
  -- Commented out bcus own     --  nvim-cmp does not ship with all sources by default. They are split
  -- Commented out bcus own     --  into multiple repos for maintenance purposes.
  -- Commented out bcus own     'hrsh7th/cmp-nvim-lsp',
  -- Commented out bcus own     'hrsh7th/cmp-path',
  -- Commented out bcus own   },
  -- Commented out bcus own   config = function()
  -- Commented out bcus own     -- See `:help cmp`
  -- Commented out bcus own     local cmp = require 'cmp'
  -- Commented out bcus own     local luasnip = require 'luasnip'
  -- Commented out bcus own     luasnip.config.setup {}

  -- Commented out bcus own     cmp.setup {
  -- Commented out bcus own       snippet = {
  -- Commented out bcus own         expand = function(args)
  -- Commented out bcus own           luasnip.lsp_expand(args.body)
  -- Commented out bcus own         end,
  -- Commented out bcus own       },
  -- Commented out bcus own       completion = { completeopt = 'menu,menuone,noinsert' },

  -- Commented out bcus own       -- For an understanding of why these mappings were
  -- Commented out bcus own       -- chosen, you will need to read `:help ins-completion`
  -- Commented out bcus own       --
  -- Commented out bcus own       -- No, but seriously. Please read `:help ins-completion`, it is really good!
  -- Commented out bcus own       mapping = cmp.mapping.preset.insert {
  -- Commented out bcus own         -- Select the [n]ext item
  -- Commented out bcus own         ['<C-n>'] = cmp.mapping.select_next_item(),
  -- Commented out bcus own         -- Select the [p]revious item
  -- Commented out bcus own         ['<C-p>'] = cmp.mapping.select_prev_item(),

  -- Commented out bcus own         -- Scroll the documentation window [b]ack / [f]orward
  -- Commented out bcus own         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  -- Commented out bcus own         ['<C-f>'] = cmp.mapping.scroll_docs(4),

  -- Commented out bcus own         -- Accept ([y]es) the completion.
  -- Commented out bcus own         --  This will auto-import if your LSP supports it.
  -- Commented out bcus own         --  This will expand snippets if the LSP sent a snippet.
  -- Commented out bcus own         ['<C-y>'] = cmp.mapping.confirm { select = true },

  -- Commented out bcus own         -- If you prefer more traditional completion keymaps,
  -- Commented out bcus own         -- you can uncomment the following lines
  -- Commented out bcus own         --['<CR>'] = cmp.mapping.confirm { select = true },
  -- Commented out bcus own         --['<Tab>'] = cmp.mapping.select_next_item(),
  -- Commented out bcus own         --['<S-Tab>'] = cmp.mapping.select_prev_item(),

  -- Commented out bcus own         -- Manually trigger a completion from nvim-cmp.
  -- Commented out bcus own         --  Generally you don't need this, because nvim-cmp will display
  -- Commented out bcus own         --  completions whenever it has completion options available.
  -- Commented out bcus own         ['<C-Space>'] = cmp.mapping.complete {},

  -- Commented out bcus own         -- Think of <c-l> as moving to the right of your snippet expansion.
  -- Commented out bcus own         --  So if you have a snippet that's like:
  -- Commented out bcus own         --  function $name($args)
  -- Commented out bcus own         --    $body
  -- Commented out bcus own         --  end
  -- Commented out bcus own         --
  -- Commented out bcus own         -- <c-l> will move you to the right of each of the expansion locations.
  -- Commented out bcus own         -- <c-h> is similar, except moving you backwards.
  -- Commented out bcus own         ['<C-l>'] = cmp.mapping(function()
  -- Commented out bcus own           if luasnip.expand_or_locally_jumpable() then
  -- Commented out bcus own             luasnip.expand_or_jump()
  -- Commented out bcus own           end
  -- Commented out bcus own         end, { 'i', 's' }),
  -- Commented out bcus own         ['<C-h>'] = cmp.mapping(function()
  -- Commented out bcus own           if luasnip.locally_jumpable(-1) then
  -- Commented out bcus own             luasnip.jump(-1)
  -- Commented out bcus own           end
  -- Commented out bcus own         end, { 'i', 's' }),

  -- Commented out bcus own         -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
  -- Commented out bcus own         --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  -- Commented out bcus own       },
  -- Commented out bcus own       sources = {
  -- Commented out bcus own         {
  -- Commented out bcus own           name = 'lazydev',
  -- Commented out bcus own           -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
  -- Commented out bcus own           group_index = 0,
  -- Commented out bcus own         },
  -- Commented out bcus own         { name = 'nvim_lsp' },
  -- Commented out bcus own         { name = 'luasnip' },
  -- Commented out bcus own         { name = 'path' },
  -- Commented out bcus own       },
  -- Commented out bcus own     }
  -- Commented out bcus own   end,
  -- Commented out bcus own },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'Chiel92/vim-autoformat',
    config = function()
      -- Autoformat configuration
      -- Trigger autoformat on save
      vim.cmd [[
        augroup AutoFormatGroup
          autocmd!
          autocmd BufWrite * :Autoformat
        augroup END
      ]]

      -- Disable autoindent and retab, but enable removing trailing spaces
      vim.g.autoformat_autoindent = 0
      vim.g.autoformat_retab = 0
      vim.g.autoformat_remove_trailing_spaces = 1
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
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

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- If just one -- -- Set up lspconfig with nvim-cmp capabilities
-- If just one -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- If just one --
-- If just one -- -- Replace `<YOUR_LSP_SERVER>` with each LSP server you want to set up.
-- If just one -- local lspconfig = require('lspconfig')
-- If just one -- lspconfig['<YOUR_LSP_SERVER>'].setup {
-- If just one --   capabilities = capabilities,
-- If just one -- }
-- Import capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up automatic LSP attachment for installed servers
local lspconfig = require 'lspconfig'
require('mason-lspconfig').setup_handlers {
  -- Default handler (applies to all installed servers)
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Define buffer-local keybindings if needed
      end,
    }
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.cmd 'Neotree'
vim.cmd 'vertical resize -12'
-- Switch focus back to the main text window
vim.defer_fn(function()
  vim.cmd 'wincmd l'
end, 5)

-- Auto-close Neotree if it's the last window open
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if #vim.api.nvim_tabpage_list_wins(0) == 1 and vim.bo.filetype == 'neo-tree' then
      vim.cmd 'q'
    end
  end,
})
-- Disable Shada (session) Data
vim.opt.shadafile = 'NONE'

vim.api.nvim_set_keymap('i', '{', '{}<Esc>ha', { noremap = true })
vim.api.nvim_set_keymap('i', '(', '()<Esc>ha', { noremap = true })
vim.api.nvim_set_keymap('i', '[', '[]<Esc>ha', { noremap = true })
vim.api.nvim_set_keymap('i', '"', '""<Esc>ha', { noremap = true })
vim.api.nvim_set_keymap('i', "'", "''<Esc>ha", { noremap = true })
vim.api.nvim_set_keymap('i', '`', '``<Esc>ha', { noremap = true })
