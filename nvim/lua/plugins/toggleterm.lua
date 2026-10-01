return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,                     -- Height of bottom terminal in lines
      open_mapping = [[<C-\>]],     -- Shortcut to toggle terminal on/off
      hide_numbers = true,
      shade_terminals = false,      -- Disabled so it doesn't darken your transparent background
      direction = "horizontal",     -- 'horizontal' (bottom pane), 'vertical', or 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
      },
      -- Transparency integration
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_set_option_value("winblend", 0, { scope = "local" })

        -- Force terminal window highlights to use standard transparent editor colors
        local win = term.window
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,NormalNC:NormalNC")
        end
      end,
    })

    -- Easy navigation out of terminal mode using Esc or Ctrl+w
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
      end,
    })
  end,
}
