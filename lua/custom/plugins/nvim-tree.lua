return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      on_attach = function(bufnr)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        local ok, api = pcall(require, 'nvim-tree.api')
        assert(ok, 'api module is not found')
        vim.keymap.set('n', '<CR>', api.node.open.tab_drop, opts 'Tab drop')
      end,
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    }
  end,
}
