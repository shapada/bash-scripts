#!/bin/sh

# fuzzy_win launches the script from param in a centered window
xdotool search --onlyvisible --classname URxvtFuzzy windowunmap \
  || xdotool search --classname URxvtFuzzy windowmap \
  || urxvtc -name URxvtFuzzy -geometry 40x8+297+1 -hold -e $1