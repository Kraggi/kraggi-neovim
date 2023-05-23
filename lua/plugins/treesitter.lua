require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "lua", "tsx", "javascript", "html" },

  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
