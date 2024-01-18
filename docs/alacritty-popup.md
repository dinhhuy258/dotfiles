# Alacritty popup

I'm now creating a instance of Alacritty specifically for popup action. The issue is that using two instances of Alacritty simultaneously—one for coding and the other for popups—is somewhat difficult.

## How to build Alacritty Popup

1. Clone [this](https://github.com/dinhhuy258/alacritty) repository. 
2. Checkout branch `git checkout origin/v0.9.0`
3. Run `make app`
4. The binary that is produced by the aforementioned command might not be functional. We must make a small change.

- Go to `AlacrittyPopup/Contents/MacOS/`
- Rename `alacritty` to `alacritty-popup`

## Q/A

1. Why is alacritty binary not shared in dotfiles?

It is not possible to share the binary between machines; it needs to be unique whether we are using an M1 Mac or an Intel Mac.

