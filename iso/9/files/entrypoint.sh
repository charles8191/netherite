#!/bin/bash

curl -Lo /upstream.iso https://repo.almalinux.org/development/almalinux/9/bootc/isos/x86_64/AlmaLinux-9-latest-x86_64-boot.iso
rm -vf /output/upstream.iso || true
mkksiso --ks /ks.ks /upstream.iso /output/9.iso
