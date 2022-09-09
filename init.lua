local async

async = vim.loop.new_async(vim.schedule_wrap(function()
  require '_globals'
  require '_settings'
  require '_plugins'
  require '_autocommands'
  require 'core.plugins'
  require 'core.lsp'
  require 'core.cmp'
end))

async:send()
