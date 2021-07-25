# Emacs config
## Quick setup
Clone this repository and:

`ln -s ./emacs.json ~/.config/karabiner/assets/complex_modifications/emacs.json`

`ln -s ./init.el ~/.config/emacs/init.el`
## Key mapping
Place [emacs.json](./emacs.json) in `~/.config/karabiner/assets/complex_modifications/`. Open [Karabiner-Elements](https://karabiner-elements.pqrs.org/) and in the Complex modifications tab click on "Add rule", then click on "Enable All" at the top. This switches the left ctrl and ⌘ keys and assigns left ⌥/alt to the right ⌘ key. [[1]](#1)

## macOS quirks
In `System Preferences → Security & Privacy → Privacy` choose `Full Disk Access` in the left column, then add `/usr/bin/ruby`.[[2]](#2) (Press ⌘-Shift-dot to show hidden files)

## References
<a id="1">[1]</a>
[https://nickdrozd.github.io/2019/12/28/emacs-mac-mods.html](https://nickdrozd.github.io/2019/12/28/emacs-mac-mods.html)

<a id="2">[2]</a>
[https://emacs.stackexchange.com/a/53037](https://emacs.stackexchange.com/a/53037)