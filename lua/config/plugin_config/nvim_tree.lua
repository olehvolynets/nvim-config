-------------------------------------------------------
--------------------  NVIM TREE  ----------------------
-------------------------------------------------------

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_icon_padding = ''
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  folder_arrows = 1,
  files = 0,
}
vim.g.nvim_tree_icons = {
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  }
}

local tree_cb = require('nvim-tree.config').nvim_tree_callback

local mappings = {
  { key = {'<CR>', 'o', '<2-LeftMouse>'}, cb = tree_cb('edit') },
  { key = 'C',                            cb = tree_cb('cd') },
  { key = 's',                            cb = tree_cb('vsplit') },
  { key = 'i',                            cb = tree_cb('split') },
  { key = 't',                            cb = tree_cb('tabnew') },
  { key = '<',                            cb = tree_cb('prev_sibling') },
  { key = '>',                            cb = tree_cb('next_sibling') },
  { key = 'P',                            cb = tree_cb('parent_node') },
  { key = 'x',                         cb = tree_cb('close_node') },
  { key = '<S-CR>',                       cb = tree_cb('close_node') },
  { key = '<Tab>',                        cb = tree_cb('preview') },
  { key = 'K',                            cb = tree_cb('first_sibling') },
  { key = 'J',                            cb = tree_cb('last_sibling') },
  { key = 'I',                            cb = tree_cb('toggle_ignored') },
  { key = 'H',                            cb = tree_cb('toggle_dotfiles') },
  { key = 'R',                            cb = tree_cb('refresh') },
  { key = 'a',                            cb = tree_cb('create') },
  { key = 'd',                            cb = tree_cb('remove') },
  { key = 'r',                            cb = tree_cb('rename') },
  { key = '<C-r>',                        cb = tree_cb('full_rename') },
  -- { key = 'x',                            cb = tree_cb('cut') },
  { key = 'c',                            cb = tree_cb('copy') },
  { key = 'p',                            cb = tree_cb('paste') },
  { key = 'y',                            cb = tree_cb('copy_name') },
  { key = 'Y',                            cb = tree_cb('copy_path') },
  { key = 'gy',                           cb = tree_cb('copy_absolute_path') },
  { key = '[c',                           cb = tree_cb('prev_git_item') },
  { key = ']c',                           cb = tree_cb('next_git_item') },
  { key = 'U',                            cb = tree_cb('dir_up') },
  { key = 'q',                            cb = tree_cb('close') },
  { key = '?',                            cb = tree_cb('toggle_help') },
}

require('nvim-tree').setup({
  disable_netrw = true,
  hijack_cursor = true,
  view = {
    width = 35,
    mappings = {
      only_custom = true,
      list = mappings
    }
  },
  filters = {
    dotfiles = true
  }
})

vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', default_opts)
