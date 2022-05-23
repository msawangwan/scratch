#!/bin/bash
# dd-keypress.sh: Capture keystrokes without needing to press ENTER.
# see:
# - https://tldp.org/LDP/abs/html/extmisc.html#EXERCISINGDD
# - https://tldp.org/LDP/abs/html/system.html#KEYPRESS

keypresses=4 # Number of keypresses to capture.

old_tty_setting=$(stty -g) # Save old terminal settings.

echo "Press $keypresses keys."
stty -icanon -echo # Disable canonical mode.
# Disable local echo.
keys=$(dd bs=1 count=$keypresses 2>/dev/null)
# 'dd' uses stdin, if "if" (input file) not specified.

stty "$old_tty_setting" # Restore old terminal settings.

echo "You pressed the \"$keys\" keys."

# Thanks, Stephane Chazelas, for showing the way.
exit 0
