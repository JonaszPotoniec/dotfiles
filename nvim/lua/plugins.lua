return {
  {
    "lambdalisue/vim-suda",
    event = "BufReadPre",
  },
  { 
    "catppuccin/nvim",
    name = "catppuccin", 
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  }
}

