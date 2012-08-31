#!/bin/bash

##%%%%%
#% theosinstall.sh
#% Extracted (not modified whatsoever) by theiostream on 30/08/2012
#% Created by BigBoss, taken from 'bigbosshackertools'
#%
#% theosinstall -- Install theos. Nothing else.
#% theiostream utilities
##%%%%%

echo "deb http://coredev.nl/cydia iphone main" > /etc/apt/sources.list.d/coredev1.nl.list
echo "deb http://nix.howett.net/theos ./" > /etc/apt/sources.list.d/howett1.net.list

apt-get update
apt-get -y --force-yes install perl net.howett.theos

rm -f /etc/apt/sources.list.d/howett1.net.list
rm -f /etc/apt/sources.list.d/coredev1.nl.list