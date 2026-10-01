return {

  -- Theme 1: Nightfox (Carbonfox)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Theme 2: Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
  },

  -- Theme 3: Midnight
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
  },
}
