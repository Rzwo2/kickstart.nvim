return {
  'nickkadutskyi/jb.nvim',
  lazy = false,
  priority = 999,
  opts = {},
  config = function()
    -- require("jb").setup({transparent = true})
    vim.cmd 'colorscheme jb'
  end,
}
