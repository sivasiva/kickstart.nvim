return {
  -- {
  --   "jvgrootveld/telescope-zoxide",
  --   dependencies = {
  --     "nvim-lua/popup.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  { -- REF: https://github.com/andrewthauer/dotfiles/blob/5cb699738f37b5f4247526e189dfa0bd30ea7e19/modules/neovim/.config/nvim/lua/plugins/session.lua#L5
    'coffebar/neovim-project',
    lazy = false,
    priority = 100,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
      { 'Shatur/neovim-session-manager' },
    },
    keys = {
      { '<leader>fp', ':Telescope neovim-project discover<cr>', desc = 'Find project' },
      { '<leader>fP', ':NeovimProjectLoadRecent<cr>', desc = 'Open last project' },
    },
    opts = {
      projects = { -- define project roots
        '~/projects/*',
        '~/projects/notes/*',
        '~/work/*',
        '~/notion/*',
        '~/work/dm23/*',
        '~/work/dm2024/*',
        '~/work/e/*',
        '~/.config/*',
        '~/.config/*',
      },
      dashboard_mode = true,
      session_manager_opts = {
        autosave_last_session = true,
        autosave_only_in_session = false,
        autosave_ignore_not_normal = false,
      },
    },
    last_session_on_startup = false,
    init = function()
      -- enable saving the state of plugins in the session
      -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
      vim.opt.sessionoptions:append 'globals'
    end,
  },
  {
    'folke/which-key.nvim',
    opts = function(_, opts)
      local wk = require 'which-key'
      wk.register {
        ['<leader>p'] = {
          l = { '<cmd>Telescope neovim-project discover<cr>', 'Find project' },
          f = { '<cmd>Telescope neovim-project discover<cr>', 'Find project' },
          h = { '<cmd>Telescope neovim-project history<cr>', 'Project History' },
          r = { '<cmd>NeovimProjectLoadRecent<cr>', 'Open recent project' },
        },
        ['<leader>z'] = {
          l = { '<cmd>Telescope zoxide list<cr>', 'List directories' },
          -- h = { "<cmd>Telescope neovim-project history<cr>", "Project History" },
          -- l = { "<cmd>NeovimProjectLoadRecent<cr>", "Open recent project" },
        },
      }
    end,
  },
}
