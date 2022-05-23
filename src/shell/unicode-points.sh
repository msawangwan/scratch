#!/bin/bash
#
# Given a Unicode code point 'U' and a number 'n', print n lines for each of
# the Unicode code points 'U' to 'U+n', consisting of:
#
#   1. The character 'c' corresponding to 'U'
#   2. The Unicode code point 'U'
#   3. The binary code of 'c' in the terminal's current encoding
#   4. The hexadecimal code of 'c' in the terminal's current encoding
#
# Notes:
#   - The maximal Unicode code point 'U+n' must be in the BMP (max. FFFF)
#   - The Unicode code point 'U' is given as a hex. number (i.e. without U+)
#   - Some non-printable chars like line-feed and tabs may garble the output
#   - To make sense of the output, make sure to KNOW YOUR TERMINAL'S ENCODING
#       - Run "locale", or check in the terminal's settings
#
# Daniel Weibel <danielmweibel@gmail.com> 7 July 2017
#------------------------------------------------------------------------------#

set -e

usage() {
  cat <<EOF
Usage:
  $(basename $0) code-point number
Example:
  $(basename $0) c9 32
EOF
}

# Get character corresponding to a Unicode code point in the BMP (4 hex digits)
get-char() {
  perl -C -e "print chr 0x$1"
}

# Increment a hex number by 1, pad result with to 4 digits with 0s (reads arg)
increment() {
  bc <<<"obase=ibase=16; $1 + 1"
}

# Pad a string to 4 digits with 0s (reads stdin)
pad-4() {
  stdin=$(cat)
  printf "%04s" "$stdin"
}

# Pad a string to multiples of 8 digits with 0s (reads stdin)
pad-8() {
  stdin=$(cat)
  n=$((((${#stdin}-1)/8 + 1) * 8))
  printf "%0${n}s" "$stdin"
}

# Get the hex code of a character in the terminal's encoding (reads arg)
encode() {
  echo -n "$@" | hexdump | head -1 | cut -d ' ' -f 2- | sed 's/[[:space:]]*$//'
}

# Transform all lowercase letters of a string to uppercase (reads stdin)
to-upper() {
  tr '[:lower:]' '[:upper:]'
}

# Remove all whitespace from a string (reads arg)
collapse() {
  tr -d '[:blank:]' <<<"$1"
}

# Insert a space after every 8th character of a string (reads stdin)
split-bytes() {
  sed 's/.\{8\}/& /g' | sed 's/ $//'
}

# Convert a hex number to binary (reads stdin)
to-binary() {
  stdin=$(cat)
  bc <<<"obase=2; ibase=16; $stdin"
}

if [[ "$#" -lt 2 ]]; then
  usage
  exit 1
fi

# Read command-line args
code_point=$(echo $1 | to-upper | pad-4)
n=$2

for i in $(seq 1 "$n"); do
  char=$(get-char "$code_point")
  hex_code=$(encode "$char" | to-upper)
  bin_code=$(collapse "$hex_code" | to-binary | pad-8 | split-bytes)
  echo "$char | U+$code_point | $bin_code | $hex_code"
  code_point=$(increment "$code_point" | pad-4)
done