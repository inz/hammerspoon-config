local logger = require "hs.logger"
logger.defaultLogLevel = 'warning'
local log = logger.new("init")

require "extensions.reloadconfig"
require "extensions.windowmovement"
local screenlayout = require "extensions.screenlayout"

screenlayout.start()
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "r", function ()
  screenlayout.restoreLayout()
end)

-- window hints app switcher
-- hs.hints.style = "vimperator"
hs.hotkey.bind({"cmd", "ctrl", "shift"}, "tab", function ()
  hs.hints.windowHints()
end)

hs.hotkey.bind({"alt"}, "tab", function ()
  hs.hints.windowHints()
end)

-- reload config
hs.hotkey.bind({"cmd", "ctrl", "alt", "shift"}, "r", function ()
  hs.reload()
end)

hs.hotkey.bind({"ctrl"}, "`", function()
  os.execute('bin/toggle_terminal')
end)

local function table_equals(aTable, otherTable)
  if aTable == otherTable then return true end
  if aTable == nil or otherTable == nil or #aTable ~= #otherTable then
    return false
  end
  for key, value in pairs(aTable) do
    if aTable[key] ~= otherTable[key] then return false end
  end
  return true
end

-- Coming soon: Window Layout
--
-- probably use grid

-- automatically hide dock when only on laptop screen
-- osascript -e 'tell application "System Events" to set the autohide of the dock preferences to true'
local screenWatcher = nil
local previousScreens = nil
local laptopScreenIdIntegrated = 2077807229
local laptopScreenIdDedicated = 69676418
local laptopScreen13Id = 69732928
local laptopScreens = { laptopScreenIdIntegrated, laptopScreenIdDedicated, laptopScreen13Id }
local externalDellU2713HMId = 722499407
local externalThunderboltUzhId = 69503329

local function screenChangedCallback()
  local screenIds = hs.fnutils.map(hs.screen.allScreens(), function (screen)
    return screen:id()
  end)
  table.sort(screenIds)
  log.i("Current Screens: " .. hs.inspect(screenIds))
  if table_equals(screenIds, previousScreens) then
    log.i("Screen layout not changed.")
    return
  end

  if #screenIds == 1 and hs.fnutils.indexOf(laptopScreens, screenIds[1]) then
    log.i 'No external screens connected.'
    -- Hide dock.
    hs.applescript.applescript('tell application "System Events" to set the autohide of the dock preferences to true')
  else
    log.i 'Show dock.'
    hs.applescript.applescript('tell application "System Events" to set the autohide of the dock preferences to false')
  end

  previousScreens = screenIds
end
screenWatcher = hs.screen.watcher.new(screenChangedCallback)
screenWatcher:start()
-- Call screen changed callback once to apply settings
screenChangedCallback()



