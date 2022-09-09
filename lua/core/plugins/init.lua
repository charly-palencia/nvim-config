local modules = {
  "core.plugins.alpha",
  "core.plugins.autopairs",
  "core.plugins.colorizer",
}

for i = 1, #modules, 1 do
  global_config.safe_require(modules[i])
end
