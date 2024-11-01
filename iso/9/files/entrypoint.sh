#!/bin/bash

curl -Lo /upstream.iso https://dl.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-x86_64-boot.iso
rm -vf /output/upstream.iso || true
mkksiso --ks /ks.ks /upstream.iso /output/9.iso
