# Karabinner

[Karabiner](https://karabiner-elements.pqrs.org/) is a software application that I use to customize my keyboard settings on macOS. It allows me to change the key mappings, and create complex modifications for different scenarios.

## Goku

However, the configuration file for Karabiner is very large and complicated. Some configuration files may have thousands of lines of code, which makes it difficult to edit and maintain them.


That's why I use [goku](https://github.com/yqrashawn/GokuRakuJoudo), a tool that simplifies the configuration process for Karabiner. Goku uses a concise and expressive syntax to write the configuration file in [edn format](https://github.com/edn-format/edn).

The goku configuration file should be placed in the `~/.config/` folder with the name `karabiner.edn`.

To convert the `karabiner.edn` file to the `karabiner.json` file that Karabiner can read, I need to run the following command in the terminal:

```sh
goku
```
