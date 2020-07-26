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

hs.hotkey.bind({"ctrl", "shift"}, "`", function()
  log.i('toggle slack')
  os.execute('bin/toggle_slack')
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

-- init grid
-- docs: https://github.com/Hammerspoon/hammerspoon/blob/master/extensions/grid/init.lua
--hs.grid.setGrid('20x20', '2560x1440')
--hs.grid.setGrid('10x10', '1440x900')
hs.grid.setGrid('40x45', '2560x1440')
hs.grid.setGrid('45x25', '1440x900')
hs.grid.setGrid('10x10')
hs.grid.setMargins(hs.geometry'0,0')


-- -- hotkey mash
local mash   = {"ctrl", "alt"}
local mash_app   = {"cmd", "alt", "ctrl"}
local mash_shift = {"ctrl", "alt", "shift"}
local mash_app_shift = {"cmd", "ctrl", "alt", "shift"}

hs.grid.ui.textSize = 20
-- move windows
hs.hotkey.bind(mash, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(mash, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(mash, 'L', hs.grid.pushWindowRight)
--
-- resize windows
hs.hotkey.bind(mash, 'Y', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash, 'U', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash, 'I', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash, 'O', hs.grid.resizeWindowWider)
