return {
  {
    -- REF: https://www.reddit.com/r/neovim/comments/1bceiw2/comment/kuhmdp9/
    'echasnovski/mini.files',
    keys = {
      {
        '-',
        function()
          require('mini.files').open()
        end,
        desc = 'Explore project files',
      },
    },

    config = function()
      require('mini.files').setup {
        mappings = {
          synchronize = 'w',
          go_in_plus = '<CR>',
        },
      }

      local show_dotfiles = true

      local filter_show = function(_)
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      local gio_open = function()
        local fs_entry = require('mini.files').get_fs_entry()
        vim.notify(vim.inspect(fs_entry))
        vim.fn.system(string.format("gio open '%s'", fs_entry.path))
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require('mini.files').refresh { content = { filter = new_filter } }
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
          vim.keymap.set('n', '-', require('mini.files').close, { buffer = buf_id })
          vim.keymap.set('n', 'o', gio_open, { buffer = buf_id })
        end,
      })
    end,

    lazy = false,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    },
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/353#discussioncomment-5637248
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            '.git',
            'node_modules',
            '.elixir_ls',
            '.elixir-tools',
            '.lexical',
            '_build',
            'deps',
          },
          never_show = {
            '.git',
            '.history',
            '.DS_Store',
            'thumbs.db',
            '.idea',
            -- hide files from these folders, when searching within Neo-Tree explorer
            '_build',
            'deps',
            '.elixir_ls',
            'dialyzer*',
            'node_modules*',
          },
        },
      },
    },
  },
}
