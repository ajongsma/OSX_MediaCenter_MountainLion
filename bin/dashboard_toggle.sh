#!/bin/sh

#function to evaluate whether the widgets are on or off
function evalwidgets {
         domainvar="com.apple.dashboard mcx-disabled"
         defaults read $domainvar
return ; }

#case statement to decide whether to turn widgets on or off
case $( evalwidgets ) in
        1 )
                echo "TURNING ON WIDGETS"
                evalwidgets
                defaults write com.apple.dashboard mcx-disabled -boolean NO;;
        0 )
                echo "TURNING OFF WIDGETS"
                evalwidgets
                defaults write com.apple.dashboard mcx-disabled -boolean YES;;
        !1 | !0 )
                echo "this is the result of evalwidgets function..."
                evalwidgets
                echo "..."
                echo "sumpin aint workin";;
esac

#kill the dock to put the widget call in effect
killall "Dock"