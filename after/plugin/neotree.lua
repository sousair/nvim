local neotree = require('neo-tree')

neotree.setup({
  enable_diagnostics = true,
  enable_git_status = true,
  sort_case_insensitive = true,

  window = {
    position = 'current',
  },

  filesystem = {
    hijack_netrw_behavior = 'open_default',
    filtered_items = {
      visible = true,
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignore = true,
      hide_by_name = {
        '.git',
        'node_modules',
      },
    },
  },

  buffers = {
    -- group_empty_dirs = true,
    show_unloaded = true,
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
  },

  git_status = {
    window = {
      position = 'float',
      -- Remap commands for git
      mappings = {
      },
    }
  },

  default_component_configs = {
    container = {
      enable_character_fate = true
    },

    ident = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },

    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "R",
        untracked = "",
        ignored   = "",
        unstaged  = "U",
        staged    = "",
        conflict  = "",
      }
    },

    file_size = {
      enabled = true,
      required_width = 64,
    },
    type = {
      enabled = true,
      required_width = 122,
    },
  },

  event_handlers = {
    {
      event = 'neo_tree_buffer_enter',
      handler = function()
        vim.opt_local.relativenumber = true
      end,
    }
  },
})
