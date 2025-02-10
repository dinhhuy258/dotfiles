# Macos

## Increase keyboard key repeat rate

**Method 1**

1. Go to `Settings -> Keyboard`.
2. Increase `Key repeat rate` and `Delay until repeat` values to maximum.

**Method 2**

Run following commands on the terminal:

```sh
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```

## Keyboard settings

- Change input source: `hyper+tab`
- Disable all screenshot shortcuts

## Dock settings

- Go to `Desktop & Dock`
- Update `Position on screen` to `Left`
- Enable `Automatically hide and show the Dock`

## Menu bar settings

- Go to `Control Center`
- `Bluetooth` set `Show in Menu Bar`
- Set `Automatically hide and show the menu bar` to `Always`

## Disable windows opening animations

```sh
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
```
