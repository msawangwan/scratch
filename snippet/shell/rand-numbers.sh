#!/usr/bin/env bash -e

# http://www.mark-jensen.org/blog/2015/3/25/generating-random-numbers-in-a-linux-shell-script

exec 19< /dev/random # or you could open /dev/random each time in each fx

random_s32() { 
    od -An -td4 -N4 <&19; 
}# signed 32-bit

random_u32() { 
    od -An -tu4 -N4 <&19;
}# unsigned 32-bit

random_s16() { 
    od -An -td2 -N2 <&19;
}# signed 16-bit

random_u16() { 
    od -An -tu2 -N2 <&19;
}# unsigned 16-bit

random_u31() { 
    local x=$(random_s32)
    echo "${x#*-}"
}
random_u15() { 
    local x=$(random_s16)
    echo "${x#*-}"
}

# of course you can adapt the above to any other sort of int...
