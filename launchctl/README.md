## WORK IN PROGRESS - PLEASE IGNORE FOR NOW ##

 --- 

===

~~~


OSX Snow Mountain Lion Launchctl Items
===
Launcher and Deamon scripts to start when Mac OSX system boots.

Create the directories and a log file
---
    sudo mkdir -p /var/log
    sudo touch /var/log/filename.log

Install/Reinstall Launchctl Item:
---
    sudo cp org.<something><something>.plist /System/Library/LaunchDaemons/
    sudo chown root:wheel /System/Library/LaunchDaemons/org.<something><something>.plist
    plutil -lint com.<something><something>.plist
    launchctl start org.<something><something>.plist

    sudo launchctl stop org.<something><something>
    sudo launchctl unload /System/Library/LaunchDaemons/org.<something><something>.plist
    sudo launchctl load /System/Library/LaunchDaemons/org.<something><something>.plist
    sudo launchctl start org.<something><something>


Configuration
---
If your paths are different, you'll need to manually change both the plist file and install script

Other Info
---
