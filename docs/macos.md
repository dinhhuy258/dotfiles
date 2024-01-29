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
