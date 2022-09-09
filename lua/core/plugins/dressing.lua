require('dressing').setup({
  select = {
    enabled = true,
    -- Priority list of preferred vim.select implementations
    backend = { "telescope", "nui", "fzf_lua", "fzf", "builtin" },
  }
})


