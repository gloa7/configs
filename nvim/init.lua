require("config.lazy")







-- Keep at end of init.lua
-- Force transparent backgrounds whenever ANY colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local hl_groups = { "Normal", "NormalNC", "SignColumn", "LineNr", "Folded", "EndOfBuffer" }
    for _, group in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
    end
  end,
})

vim.cmd.colorscheme "midnight"

