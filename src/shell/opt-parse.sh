#!/bin/bash
#
## illustrates tab-expansion of command-line options.
##
## see:
## - https://tldp.org/LDP/abs/html/contributed-scripts.html#USEGETOPT2
## - the "Introduction to Tab Expansion" appendix
##
## usage:
##
##  Possible options: -a -d -f -l -t -h
##                   --aoption, --debug --file --log --test -- help --
#

# # UseGetOpt () {
# declare inputOptions
# declare -r E_OPTERR=85
# declare -r ScriptName=${0##*/}
# declare -r ShortOpts="adf:hlt"
# declare -r LongOpts="aoption,debug,file:,help,log,test"

# DoSomething() {
#     echo "The function name is '${FUNCNAME}'"
# }

# inputOptions=$(getopt -o "${ShortOpts}" --long \
#     "${LongOpts}" --name "${ScriptName}" -- "${@}")

# if [[ ($? -ne 0) || ($# -eq 0) ]]; then
#     echo "Usage: ${ScriptName} [-dhlt] {OPTION...}"
#     exit $E_OPTERR
# fi

# eval set -- "${inputOptions}"

# while true; do
#     case "${1}" in
#     --aoption | -a) # Argument found.
#         echo "Option [$1]"
#         ;;

#     --debug | -d) # Enable informational messages.
#         echo "Option [$1] Debugging enabled"
#         ;;

#     --file | -f)     #  Check for optional argument.
#         case "$2" in #+ Double colon is optional argument.
#         "")          #  Not there.
#             echo "Option [$1] Use default"
#             shift
#             ;;

#         *) # Got it
#             echo "Option [$1] Using input [$2]"
#             shift
#             ;;

#         esac
#         DoSomething
#         ;;

#     --log | -l) # Enable Logging.
#         echo "Option [$1] Logging enabled"
#         ;;

#     --test | -t) # Enable testing.
#         echo "Option [$1] Testing enabled"
#         ;;

#     --help | -h)
#         echo "Option [$1] Display help"
#         break
#         ;;

#     --) # Done! $# is argument number for "--", $@ is "--"
#         echo "Option [$1] Dash Dash"
#         break
#         ;;

#     *)
#         echo "Major internal error!"
#         exit 8
#         ;;

#     esac
#     echo "Number of arguments: [$#]"
#     shift
# done

# shift

# #  }

# exit

## The following code fragment shows how one might process the arguments for a
## command that can take the options -a and -b, and the option -o, which
## requires an argument.
##
## This code will accept any of the following as equivalent:
##
##     cmd -aoarg file file
##     cmd -a -o arg file file
##     cmd -oarg -a file file
##     cmd -a -oarg -- file fil

args=$(getopt abo: $*)
# you should not use `getopt abo: "$@"` since that would parse
# the arguments differently from what the set command below does.
if [ $? != 0 ]; then
    echo 'Usage: ...'
    exit 2
fi

set -- $args
# You cannot use the set command with a backquoted getopt directly,
# since the exit code from getopt would be shadowed by those of set,
# which is zero by definition.
for i; do
    case "$i" in

    -a | -b)
        echo flag $i set
        sflags="${i#-}$sflags"
        shift
        ;;
    -o)
        echo oarg is "'"$2"'"
        oarg="$2"
        shift
        shift
        ;;
    --)
        shift
        break
        ;;
    esac
done
echo single-char flags: "'"$sflags"'"
echo oarg is "'"$oarg"'"
