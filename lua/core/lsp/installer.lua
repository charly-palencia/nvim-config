require('mason').setup({
  ui = {
    -- Accepts same border values as |nvim_open_win()|.
    border = 'none',

    icons = {
      -- package_installed = '◍',
      -- package_pending = '◍',
      -- package_uninstalled = '◍',
      package_pending = '',
      package_installed = '',
      package_uninstalled = 'ﮊ',
    },
  },
})

require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "solargraph", 'cssls', 'tailwindcss', 'tsserver', 'yamlls', 'graphql'},
    automatic_installation = true,
})
