#!/bin/bash

# Using set with the -- option explicitly assigns the contents of a variable to the
# positional parameters. If no variable follows the -- it unsets the positional parameters

variable="one two three four five"

set -- $variable
# Sets positional parameters to the contents of "$variable".

first_param=$1
second_param=$2
shift
shift # Shift past first two positional params.
# shift 2             also works.
remaining_params="$*"

echo
echo "first parameter = $first_param"           # one
echo "second parameter = $second_param"         # two
echo "remaining parameters = $remaining_params" # three four five

echo
echo

# Again.
set -- $variable
first_param=$1
second_param=$2
echo "first parameter = $first_param"   # one
echo "second parameter = $second_param" # two

# ======================================================

set --
# Unsets positional parameters if no variable specified.

first_param=$1
second_param=$2
echo "first parameter = $first_param"   # (null value)
echo "second parameter = $second_param" # (null value)

exit 0

### an example

# #!/bin/bash

# # Invoke this script with three command-line parameters,
# # for example, "sh ex34.sh one two three".

# echo
# echo "Positional parameters before  set \`uname -a\` :"
# echo "Command-line argument #1 = $1"
# echo "Command-line argument #2 = $2"
# echo "Command-line argument #3 = $3"

# set $(uname -a) # Sets the positional parameters to the output
# # of the command `uname -a`

# echo
# echo +++++
# echo $_ # +++++
# # Flags set in script.
# echo $- # hB
# #                Anomalous behavior?
# echo

# echo "Positional parameters after  set \`uname -a\` :"
# # $1, $2, $3, etc. reinitialized to result of `uname -a`
# echo "Field #1 of 'uname -a' = $1"
# echo "Field #2 of 'uname -a' = $2"
# echo "Field #3 of 'uname -a' = $3"
# echo \#\#\#
# echo $_ # ###
# echo

# exit 0

### another version

# #!/bin/bash
# # revposparams.sh: Reverse positional parameters.
# # Script by Dan Jacobson, with stylistic revisions by document author.

# set a\ b c d\ e;
# #     ^      ^     Spaces escaped
# #       ^ ^        Spaces not escaped
# OIFS=$IFS; IFS=:;
# #              ^   Saving old IFS and setting new one.

# echo

# until [ $# -eq 0 ]
# do          #      Step through positional parameters.
#   echo "### k0 = "$k""     # Before
#   k=$1:$k;  #      Append each pos param to loop variable.
# #     ^
#   echo "### k = "$k""      # After
#   echo
#   shift;
# done

# set $k  #  Set new positional parameters.
# echo -
# echo $# #  Count of positional parameters.
# echo -
# echo

# for i   #  Omitting the "in list" sets the variable -- i --
#         #+ to the positional parameters.
# do
#   echo $i  # Display new positional parameters.
# done

# IFS=$OIFS  # Restore IFS.

# #  Question:
# #  Is it necessary to set an new IFS, internal field separator,
# #+ in order for this script to work properly?
# #  What happens if you don't? Try it.
# #  And, why use the new IFS -- a colon -- in line 17,
# #+ to append to the loop variable?
# #  What is the purpose of this?

# exit 0

# $ ./revposparams.sh

# ### k0 =
# ### k = a b

# ### k0 = a b
# ### k = c a b

# ### k0 = c a b
# ### k = d e c a b

# -
# 3
# -

# d e
# c
# a b
