#! /usr/local/bin/bash

defaults write com.apple.dock "autohide" -bool "true"
killall Dock

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture 2
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# cmd+ctrlを押しながらドラッグするとウィンドウを移動できるようにする
defaults write -g NSWindowShouldDragOnGesture -bool true

echo "設定を適用するためには再起動してください"
