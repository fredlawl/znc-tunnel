#!/usr/bin/env bash

PLIST=com.fredlawl.znc.plist

sudo cp $PLIST /Library/LaunchDaemons
$(cd /Library/LaunchDaemons && sudo chmod 644 $PLIST)
$(cd /Library/LaunchDaemons && sudo chown root:wheel $PLIST)
sudo launchctl load -w /Library/LaunchDaemons/$PLIST
