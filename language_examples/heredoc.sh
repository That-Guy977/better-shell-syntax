#!/bin/sh
if [ -d "$directory" ]
    then
# syntax broken after
        mount_script=`/usr/bin/osascript <<EOF
            tell application "Finder"
            activate
            mount volume "smb://$myshare"
            end tell
            EOF`
    else
        echo blah
fi
echo another code here
exit 0

