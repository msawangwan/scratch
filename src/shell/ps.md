Useful:

          watch -n 'ps -a'

To see every process on the system using standard syntax:

          ps -e
          ps -ef
          ps -eF
          ps -ely

To see every process on the system using BSD syntax:

          ps ax
          ps axu

To print a process tree:

          ps -ejH
          ps axjf

To see every process running as root (real & effective ID) in user format:

          ps -U root -u root u

To see every process with a user-defined format:

          ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
          ps axo stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm
          ps -Ao pid,tt,user,fname,tmout,f,wchan

Print only the process IDs of syslogd:

          ps -C syslogd -o pid=

Print only the name of PID 42:

          ps -q 42 -o comm=
