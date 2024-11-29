#!/bin/bash

curl -Lo /upstream.iso https://repo.almalinux.org/almalinux/9/BaseOS/x86_64/os/images/boot.iso
rm -vf /output/upstream.iso || true
mkksiso --ks /ks.ks /upstream.iso /output/9.iso
