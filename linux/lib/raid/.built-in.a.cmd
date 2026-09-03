savedcmd_lib/raid/built-in.a := rm -f lib/raid/built-in.a;  printf "lib/raid/%s " xor/built-in.a raid6/built-in.a | xargs ar cDPrST lib/raid/built-in.a
