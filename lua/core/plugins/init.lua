local tab_modules = {
  "core.plugins.alpha",
  "core.plugins.autopairs",
  "core.plugins.colorizer",
}

for i = 1, #tab_modules, 1 do
  global_config.safe_require(tab_modules[i])
end
