# Macos

## Increase keyboard key repeat rate

1. Go to `Settings -> Keyboard`.
2. Increase `Key repeat rate` and `Delay until repeat` values to maximum.

```sh
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```
