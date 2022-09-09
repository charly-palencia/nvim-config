local lsp_colors = require('lsp-colors')
local fidget = require("fidget")
-- local lightbulb = require('nvim-lightbulb')
local lsp_saga = require('lspsaga')
local toggle_lsp_diagnostics = require('toggle_lsp_diagnostics')
-- local trouble = require('trouble')
-- local null_ls = require('null-ls')

local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

lsp_saga.init_lsp_saga({
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  -- show diagnostic source
  show_diagnostic_source = true,
  --the range of 0 for fully opaque window (disabled) to 100 for fully
  --transparent background. Values between 0-30 are typically most useful.
  saga_winblend = 10,
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = '<C-p>', next = '<C-l>' },
  max_preview_lines = 20,
  symbol_in_winbar = {
    in_custom = false, -- enable later when LSPs support documentSymbol
    enable = true,
  },
  code_action_icon = "💡",
  code_action_num_shortcut = true,
  code_action_lightbulb = {
    sign = false,
    enable = true,
    virtual_text = true,
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
})

toggle_lsp_diagnostics.init()
fidget.setup({
  window = {
    blend = 0,
  }
})

lsp_colors.setup({})
