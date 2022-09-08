local async

async = vim.loop.new_async(vim.schedule_wrap(function()
  -- require the files you want to load asynchronously here
  require '_globals'
  require '_plugins'
  require 'settings'
  require 'yoliani.plugins'
  require 'core.mappings'
  require 'core.autocmds'
  require 'core.commands'
end))

async:send()
