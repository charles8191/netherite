#!/bin/bash

curl -Lo /upstream.iso https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso
rm -vf /output/upstream.iso || true
mkksiso --ks /ks.ks /upstream.iso /output/9.iso
