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

These locations were chosen because that is how most of the other stuff like **mysql** and **redis** gets installed.

Install/Reinstall Launchctl Item:
---
    sudo cp org.<something><something>.plist /System/Library/LaunchDaemons/
    sudo chown root:wheel /System/Library/LaunchDaemons/org.<something><something>.plist

    sudo cp org.<something><something>.plist /System/Library/LaunchDaemons/
    sudo chown root:wheel /System/Library/LaunchDaemons/org.<something><something>.plist

    sudo cp org.<something><something>.plist /System/Library/LaunchDaemons/
    sudo chown root:wheel /System/Library/LaunchDaemons/org.<something><something>.plist

    sudo cp org.<something><something>.plist /System/Library/LaunchDaemons/
    sudo chown root:wheel /System/Library/LaunchDaemons/org.<something><something>.plist

    sudo cp org.<something><something>.plist /System/Library/LaunchDaemons/
    sudo chown root:wheel /System/Library/LaunchDaemons/org.<something><something>.plist

    sudo launchctl stop org.<something><something>
    sudo launchctl unload /System/Library/LaunchDaemons/org.<something><something>.plist
    sudo launchctl load /System/Library/LaunchDaemons/org.<something><something>.plist
    sudo launchctl start org.<something><something>


Configuration
---
If your paths are different, you'll need to manually change both the plist file and install script

Other Info
---
If you would prefer to install a mac StartupItem (instead of Launchctl item) use [mongodb-mac-startup](http://github.com/bratta/mongodb-mac-startup)

Idea for this was borrowed from an [article on "Cupcake With Sprinkles" blog](http://www.cupcakewithsprinkles.com/mongodb-startup-item/) and [MongoDB OSX] (https://github.com/AndreiRailean/MongoDB-OSX-Launchctl)
