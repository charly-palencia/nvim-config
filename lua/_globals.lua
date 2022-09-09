_G.global_config = {}
GUARAPO = {
  options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    -- colorcolumn = "80",
    -- colorcolumn = "120",
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    laststatus = 3,
    showcmd = false,
    ruler = false,
    -- relativenumber = true,                  -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    scrolloff = 8, -- is one of my fav
    sidescrolloff = 8,
    guifont = "monospace:h17", -- the font used in graphical neovim applications
  },
  ui = {
    float = {
      border = 'rounded',
      highlight = 'NightflyRed', -- check available by :Telescope highlights
    },
  },
  plugins = {
    package_info = {
      enabled = false,
    },
    rooter = {
      -- Removing package.json from list in Monorepo Frontend Project can be helpful
      -- By that your live_grep will work related to whole project, not specific package
      patterns = { '.git', 'package.json', '_darcs', '.bzr', '.svn', 'Makefile' }, -- Default
    },
  },
  -- LSP settings (for overriding per client)
  -- Load servers (They will be automatically installed after next "Sync plugins" launch)
  -- Check installed servers by :LspInstallInfo
  lsp = {
    servers = {
      -- 'bash',
      -- 'css',
      -- 'eslint',
      -- 'graphql',
      -- 'html',
      -- 'json',
      -- 'lua',
      -- 'tailwind',
      -- 'tsserver',
      -- 'vue2'
    },
  },
  plugins_config = {
    mason = {
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

    },
    mason_lspconfig = {
      ensure_installed = { "sumneko_lua", "solargraph", 'cssls', 'tailwindcss', 'tsserver', 'yamlls', 'graphql' },
      automatic_installation = true,
    }
  }
}

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

D = function(module)
  local show = debug.getinfo(module)
  for k, v in pairs(show) do
    print(k, v)
  end
end

function global_config.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    P(module)
    D(module)
    vim.notify(result, vim.log.levels.ERROR, { title = string.format('Error requiring: %s', module) })
  end
  return ok, result
end

function global_config.get_icon(filename, extension, opts)
  local ok, devicons = global_config.safe_require 'nvim-web-devicons'
  if not ok then
    vim.notify 'nvim-web-devicons not installed'
  end

  local icon_str, icon_color = devicons.get_icon_color(filename, extension, { default = true })

  local icon = { str = icon_str }

  if opts.colored_icon ~= false then
    icon.hl = { fg = icon_color }
  end

  return icon
end

function global_config.find_pattern_match(tbl, val)
  return tbl and next(vim.tbl_filter(function(pattern)
    return val:match(pattern)
  end, tbl))
end

local lsp = vim.lsp
function global_config.get_lsp_names()
  local clients = {}

  for _, client in pairs(lsp.buf_get_clients(0)) do
    clients[#clients + 1] = client.name
  end

  return table.concat(clients, ' '), ' '
end

local b = vim.b
function global_config.git_branch()
  return b.gitsigns_head or '', ' '
end

-- Common function used by the git providers
local function git_diff(type)
  local gsd = b.gitsigns_status_dict

  if gsd and gsd[type] and gsd[type] > 0 then
    return tostring(gsd[type])
  end

  return ''
end

function global_config.git_diff_added()
  return git_diff 'added', '  '
end

function global_config.git_diff_removed()
  return git_diff 'removed', '  '
end

function global_config.git_diff_changed()
  return git_diff 'changed', ' 柳'
end

function global_config.git_info_exists()
  return b.gitsigns_head or b.gitsigns_status_dict
end
