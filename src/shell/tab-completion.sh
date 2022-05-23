##
## bash$ touch sample_command
## bash$ touch file1.txt file2.txt file2.doc file30.txt file4.zzz
## bash$ chmod +x sample_command
## bash$ complete -f -X '!*.txt' sample_command
##
##
## bash$ ./sample[Tab][Tab]
## sample_command
## file1.txt   file2.txt   file30.txt

## compelte -f -X

echo "$(echo env.rc/*) $HOME/zshrc $HOME/bashrc $HOME/.vimrc"

# function fcount {
# >    ls | wc -l
# > }
