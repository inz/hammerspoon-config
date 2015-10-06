# Hammerspoon Configuration

My [Hammerspoon](http://hammerspoon.org) configuration.

This config defines some keyboard shortcuts and actions I find convenient. Also includes a poor man's clone of DisplayMaid that will save the position and size of all windows on all screens.

It will also try to hide the dock if only the laptop screen is connected. For this to work you will need to fix the display IDs in `init.lua`.

## Keyboard Shortcuts

### General

* <kbd>⌘</kbd><kbd>⌥</kbd><kbd>Ctrl</kbd><kbd>Shift</kbd>-<kbd>r</kbd> reload Hammerspoon config.

### Window Movement

* <kbd>⌘</kbd><kbd>⌥</kbd><kbd>Ctrl</kbd>-{<kbd>h</kbd>|<kbd>j</kbd>|<kbd>k</kbd>|<kbd>l</kbd>} move window {left,down,up,right}.
* <kbd>⌘</kbd><kbd>⌥</kbd><kbd>Ctrl</kbd><kbd>Shift</kbd>-{<kbd>h</kbd>|<kbd>j</kbd>|<kbd>k</kbd>|<kbd>l</kbd>} move window all the way {left,down,up,right} on the current screen.
* <kbd>⌘</kbd><kbd>⌥</kbd><kbd>Ctrl</kbd>-<kbd>c</kbd> center window horizontally.
* <kbd>⌘</kbd><kbd>⌥</kbd><kbd>Ctrl</kbd><kbd>Shift</kbd>-<kbd>c</kbd> center window (horizontally and vertically).

### App Switcher

* <kbd>⌥</kbd><kbd>Tab</kbd> show app switcher

### Screen/Window Layout

* <kbd>⌘</kbd><kbd>⌥</kbd><kbd>Ctrl</kbd>-<kbd>r</kbd> restore window positions

## License

Copyright (c) 2015, Christian Inzinger

Released under the MIT License see `LICENSE` for details.