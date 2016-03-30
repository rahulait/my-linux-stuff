#!/bin/bash
#############################################################################
# File: getvolume.sh
# Author: Rahul Sharma <rahuls@ccs.neu.edu>
# Desc: checks whether the system volume is on or off and accordingly
#       displays the volume level
#
# Credits:
# http://iaindunning.com/blog/experiences-with-xmonad-and-ubuntu-12.html
#############################################################################

vol_str=$(amixer -D pulse get Master | grep 'Front Left:' | sed -E 's/(\[|\])//g')
vol_status=$(echo $vol_str | awk -F' ' '{print $6}')
vol_level=$(echo $vol_str | awk -F' ' '{print $5}')

if [ "$vol_status" = "off" ]; then
    echo "Vol: MUT"
else
    echo "Vol: $vol_level"
fi

#amixer -D pulse get Master | grep 'Front Left:' | sed -E 's/(\[|\])//g' | awk -F' ' '{if ($6 == "off") { print "Vol: MUT"; } else { print "Vol: "$5; }}'
