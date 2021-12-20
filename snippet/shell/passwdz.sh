#!/usr/bin/env bash -e

hexdump -n 8 -e '2/4 "%08x"' /dev/urandom
echo
