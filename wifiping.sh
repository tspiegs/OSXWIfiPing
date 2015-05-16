#!/bin/bash

type airport >/dev/null 2>&1 || { echo "creating airport alias"; sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/bin/airport; }

if [ -z $1 ]
then
  host=$(route -n get default | awk '/gateway/{print $2}')
else
  host=$1
fi

ping $host | while read pong; do channel=$(airport --getinfo | awk '/channel/{print "channel:"$2}'); rssi=$(airport --getinfo | awk '/agrCtlRSSI/{print "RSSI:"$2}'); bssid=$(airport --getinfo | awk '/BSSID/{print "BSSID:"$2}'); echo "$(date): $pong, $bssid, $channel, $rssi"; done
