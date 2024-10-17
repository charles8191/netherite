# :pick: Netherite

Netherite is a secure & private operating system based on [Calcite](https://git.almalinux.org/charles2/calcite), an AlmaLinux-based immutable OS.

## Features

- [hardened_malloc](https://github.com/GrapheneOS/hardened_malloc) from GrapheneOS using [hardened_malloc binary](https://github.com/charles8191/hardened_malloc)
- Mostly ANSSI-BP-028 Minimal compliant
- [LibreWolf](https://librewolf.net/) instead of Firefox
- [Some configuration files from GrapheneOS infrastructure](https://github.com/GrapheneOS/infrastructure)
- Modified `os-release` file

## Installation

You can use the [ISO](https://github.com/charles8191/netherite/releases/latest) (recommended), or use `bootc switch` if you are using Calcite, HeliumOS or just plain AlmaLinux/CentOS/Rocky bootc:

```bash
bootc switch ghcr.io/charles8191/netherite/9
```

## FAQ

### Why not use secureblue?

I prefer EL-based distros over Fedora and secureblue doesn't support bootc yet either.

### Why the name?

The name is a really hard material in the video game Minecraft, further suggesting that this is a hardened Linux distribution.
