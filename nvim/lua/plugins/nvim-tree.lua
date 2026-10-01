return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icon support
  },
  config = function()
    -- Recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      -- Enable Git integration settings
      git = {
        enable = true,
        ignore = false, -- Set to true to hide git-ignored files
        timeout = 400,
      },
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true, -- Prevents other splits from shrinking/stretching the tree
      },
      renderer = {
        group_empty = true,
        highlight_git = true, -- Highlights modified file names in color
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true, -- Displays git status icons
          },
          glyphs = {
            git = {
              unstaged  = "✗",
              staged    = "✓",
              unmerged  = "",
              renamed   = "➜",
              untracked = "★",
              deleted   = "",
              ignored   = "◌",
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Keep tree open after opening a file
          resize_window = true, -- Keep tree width fixed at 30 when opening files
          window_picker = {
            enable = true,    -- Forces files into the main editor window, NOT the tree pane
          },
        },
      },
      filters = {
        dotfiles = false,     -- Set to true to hide hidden files
      },
    })

    -- 1. Keymap to toggle the tree cleanly
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

    -- 2. Auto-close Neovim if NvimTree is the LAST window remaining
    -- (Fixes the issue where quitting a file leaves only the sidebar open)
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") then
            table.insert(invalid_win, w)
          end
        end
        if #wins - #invalid_win == 1 then
          for _, w in ipairs(invalid_win) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
