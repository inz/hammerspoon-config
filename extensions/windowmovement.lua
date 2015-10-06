--- === windowmovement ===
---
--- Move windows around

local module = {}

local hotkey = require "hs.hotkey"
local window = require "hs.window"

module.GRIDSIZE_H = 9
module.GRIDSIZE_V = 9

-- simple window movement
hotkey.bind({"cmd", "alt", "ctrl"}, "H", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
  local height = screen:frame().h
 
  f.x = f.x - (screen:frame().w / module.GRIDSIZE_V)
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "L", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.x = f.x + (screen:frame().w / module.GRIDSIZE_V)
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "K", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.y = f.y - (screen:frame().h / module.GRIDSIZE_H)
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "J", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()

  f.y = f.y + (screen:frame().h / module.GRIDSIZE_H)
  win:setFrame(f)
end)

-- move windows to screen edge
hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "H", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()

  f.x = screen:frame().x
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "L", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.x = screen:frame().x + screen:frame().w - f.w
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "K", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.y = screen:frame().y
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "J", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.y = screen:frame().y + screen:frame().h - f.h
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "C", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.x = screen:frame().x + screen:frame().w/2 - f.w/2
  win:setFrame(f)
end)

hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "C", function ()
  local win = window.focusedWindow()
  local screen = win:screen()
  local f = win:frame()
 
  f.x = screen:frame().x + screen:frame().w/2 - f.w/2
  f.y = screen:frame().y + screen:frame().h/2 - f.h/2
  win:setFrame(f)
end)
