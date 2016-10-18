#!/bin/bash

defaults write com.apple.systemuiserver menuExtras -array \
      "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
      "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
      "/System/Library/CoreServices/Menu Extras/Battery.menu" \
      "/System/Library/CoreServices/Menu Extras/Volume.menu" \
      "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
      "/System/Library/CoreServices/Menu Extras/Clock.menu"

killall Dock
killall Finder
killall SystemUIServer
