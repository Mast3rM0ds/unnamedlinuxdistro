savedcmd_sound/hda/codecs/cirrus/built-in.a := rm -f sound/hda/codecs/cirrus/built-in.a;  printf "sound/hda/codecs/cirrus/%s " cs420x.o cs421x.o | xargs ar cDPrST sound/hda/codecs/cirrus/built-in.a
