require('colorizer').setup(
  {
    '*'; -- Highlight all files
    '[Plugins]'; -- exclude vim plug
    css = { css = true; };
  },
  { mode = 'background' }
)
