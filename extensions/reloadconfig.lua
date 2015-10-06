--- === reloadconfig ===
---
--- Reload config on file change

local module = {}

-- Reload config on file change
function module.reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    -- if wifiWatcher ~= nil then wifiWatcher:stop() end
    hs.reload()
  end
end

module.pathwatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", module.reloadConfig):start()
-- hs.alert.show("Config loaded")

return module