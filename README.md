# Project halted
Unfortunately, due to hardware compatibility issues, lack of time, anxiety, etc, I have stopped developing this project. If you want a similar OS, use Secureblue, Tails or Kicksecure.

# :pick: Netherite

Netherite is a secure & private operating system based on [Calcite](https://github.com/charles8191/calcite), a Rocky Linux-based immutable OS. It fills the gap for a secure, private, user-data-persistent, secure boot-capable, desktop OS.

> [!WARNING]
> Setting up an internet connection is mandatory, otherwise installation will fail. If you can't set up an internet connection, do not install this software.

## Features

- [snmalloc](https://github.com/microsoft/snmalloc) (with checks mode) using [weekly binaries](https://github.com/charles8191/snmalloc-checks)
- Some remediations from ANSSI-BP-028 Minimal
- [LibreWolf](https://librewolf.net/) instead of Firefox
- Custom chrony config (`ntp.ovh.net`)
- Custom kernel tunables
- Modified `os-release` file
- Enhanced NetworkManager privacy

## Installation

You can use the [ISO](https://github.com/charles8191/netherite/releases/latest/download/9.iso) (highly recommended), or use `bootc switch` if you are using Calcite or just plain Rocky bootc:

```bash
bootc switch ghcr.io/charles8191/netherite/9
```

## FAQ

### Why not use secureblue?

I prefer EL-based distros over Fedora and secureblue doesn't support bootc yet either.

### Why the name?

The name is a really hard material in the video game Minecraft, further suggesting that this is a hardened Linux distribution.

### What device do you recommend for security?

A device with Windows 11 from the factory is a good baseline. Secure Boot doesn't need to be disabled. Adding a BIOS password is recommended.

Advanced users can install [Mosby](https://github.com/pbatard/Mosby) using the UEFI shell, which goes hand-in-hand with Netherite.
