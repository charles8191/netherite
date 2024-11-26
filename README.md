# :pick: Netherite

Netherite is a secure & private operating system based on [Calcite](https://github.com/charles8191/calcite), a CentOS Stream-based immutable OS. It fills the gap for a secure, private, user-data-persistent, secure boot-capable, desktop OS.

> [!IMPORTANT]
> We have changed to CentOS Stream, please reinstall.

> [!WARNING]
> Setting up an internet connection is mandatory, otherwise installation will fail. If you can't set up an internet connection, do not install this software.

## Features

- [scudo](https://source.android.com/docs/security/test/scudo) using [weekly binaries](https://github.com/charles8191/scudo)
- Some remediations from ANSSI-BP-028 Minimal
- [Cromite](https://www.cromite.org/) swapped instead of Firefox
- Custom chrony config (time.cifelli.xyz)
- Custom kernel tunables
- Modified `os-release` file
- Enhanced NetworkManager privacy

## Installation

You can use the [ISO](https://github.com/charles8191/netherite/releases/latest/download/9.iso) (highly recommended), or use `bootc switch` if you are using Calcite or just plain CentOS Stream bootc:

```bash
bootc switch ghcr.io/charles8191/netherite/9
```

## FAQ

### Why is Secure Boot not working?

Some devices have issues with CentOS Stream's shim, if you are unlucky and have such a device, disable Secure Boot.

### Why not use secureblue?

I prefer RHEL-based distros over Fedora and secureblue doesn't support bootc yet either.

### Why the name?

The name is a really hard material in the video game _Minecraft_, further suggesting that this is a hardened Linux distribution.

### What device do you recommend for security?

A device with Windows 11 from the factory is a good baseline. Secure Boot doesn't need to be disabled (unless the issue above affects you). Adding a BIOS password is recommended.

Advanced users can install [Mosby](https://github.com/pbatard/Mosby) (updates the certificates, and can generate one and add it automatically) using the UEFI shell, which goes hand-in-hand with Netherite.
