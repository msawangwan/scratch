#!/usr/bin/env bash -eE

# see:
# - https://tldp.org/LDP/abs/html/debugging.html#VARTRACE

# set -o errtrace <- same as -E

# Common signals include EXIT (0), HUP (1), INT (2), and TERM (15).
# trap "rm -f $tmp; exit" EXIT HUP INT TERM   POSIX style
# trap "rm -f $tmp; exit" 0 1 2 15            Pre-POSIX Bourne shell style

teardown() { echo "line $LINENO: teardown: clean up"; }

trap teardown HUP INT TERM ERR EXIT

# fatal prints an error message then exits: optionally pass the line number to
# provide context of the call-site as the first argument.
fatal() {
    case $1 in
    '' | *[!0-9]*)
        echo "$0: line $LINENO: fatal error:" "$@" >&2 # messages to standard error
        ;;
    *)
        local line_info="line $1:"
        shift

        echo "$0: $line_info fatal error:" "$@" >&2 # messages to standard error
        ;;
    esac

    exit 1
}

cd() {
    command cd "$@"
    echo now in $PWD
}

nonexistant() {
    this_command_DOES_NOT_EXIST
}

# nonexistant

if [ $# = 0 ]; then # not enough arguments
    fatal $LINENO not enough arguments
    # fatal not enough arguments
fi
