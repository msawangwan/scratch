#! /bin/bash
# progress-bar2.sh
# Author: Graham Ewart (with reformatting by ABS Guide author).
# Used in ABS Guide with permission (thanks!).

# Invoke this script with bash. It doesn't work with sh.

interval=1
long_interval=10

{
    trap "exit" SIGUSR1
    sleep $interval
    sleep $interval
    while true; do
        echo -n '.' # Use dots.
        sleep $interval
    done
} & # Start a progress bar as a background process.

pid=$!
trap "echo !; kill -USR1 $pid; wait $pid" EXIT # To handle ^C.

echo -n 'Long-running process '
sleep $long_interval
echo ' Finished!'

kill -USR1 $pid
wait $pid # Stop the progress bar.
trap EXIT

exit $?

### another:

# #!/bin/bash
# # progress-bar.sh

# # Author: Dotan Barak (very minor revisions by ABS Guide author).
# # Used in ABS Guide with permission (thanks!).

# BAR_WIDTH=50
# BAR_CHAR_START="["
# BAR_CHAR_END="]"
# BAR_CHAR_EMPTY="."
# BAR_CHAR_FULL="="
# BRACKET_CHARS=2
# LIMIT=100

# print_progress_bar()
# {
#         # Calculate how many characters will be full.
#         let "full_limit = ((($1 - $BRACKET_CHARS) * $2) / $LIMIT)"

#         # Calculate how many characters will be empty.
#         let "empty_limit = ($1 - $BRACKET_CHARS) - ${full_limit}"

#         # Prepare the bar.
#         bar_line="${BAR_CHAR_START}"
#         for ((j=0; j<full_limit; j++)); do
#                 bar_line="${bar_line}${BAR_CHAR_FULL}"
#         done

#         for ((j=0; j<empty_limit; j++)); do
#                 bar_line="${bar_line}${BAR_CHAR_EMPTY}"
#         done

#         bar_line="${bar_line}${BAR_CHAR_END}"

#         printf "%3d%% %s" $2 ${bar_line}
# }

# # Here is a sample of code that uses it.
# MAX_PERCENT=100
# for ((i=0; i<=MAX_PERCENT; i++)); do
#         #
#         usleep 10000
#         # ... Or run some other commands ...
#         #
#         print_progress_bar ${BAR_WIDTH} ${i}
#         echo -en "\r"
# done

# echo ""

# exit
