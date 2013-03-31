#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Configuring Remote Management"
echo "#------------------------------------------------------------------------------"

source ../config.sh

echo "-----------------------------------------------------------"
echo "| 1) Clicking on “System Preferences” from the Apple menu on the Macintosh that you want to access remotely."
echo "| "
echo "| 2) Once your System Preferences are shown, click on the “Sharing” icon in the “Internet & Wireless” menu."
echo "| "
echo "| 3) Enable the “Remote Management” option."
echo "|    You can then either select “All users”, or “Only for these users:” depending on how you'd like others to access this machine."
echo "|    If you choose “Only for these users:”, then you can add or remove users from the list using the “+” and “-” buttons."
echo "|    Regardless of what you choose, all users trying to access this Mac will need to have credentials(a user name and password) for this machine."
echo "| "
echo "| 4) Select either “All users” or “Only for these users:”) click the “Options...” button and select what abilities you would like users to have access to."
echo "|    They can can be set for all users or set on an individual basis, depending on whether or not you selected “All users“ or “Only for these users:“."
echo "| "
echo "| 5) Click “OK"
echo "-----------------------------------------------------------"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| 1) To access remotely, click on the remotes desktop, in the showed menu on the “Go” followed by “Connect to Server...” option."
echo "| "
echo "| 2) In the Connect to Server window, enter either the address or the network name of the target Mac, in the following format:"
echo "|    vnc://numeric.address.ofthe.mac (For example: vnc://192.168.1.100)"
echo "|    or"
echo "|    vnc://Hostname (where Hostname is the network name of the target Mac for example vnc://mac.local)"
echo "| "
echo "| 3) Click the Connect button."
echo "| "
echo "| 4) Enter the appropriate information, and click Connect."
echo "|    Depending on how you set up the Mac's screen sharing, you may be asked for a name and password."
echo "| "
echo "| A new window will open, displaying the target Mac's desktop."
echo "-----------------------------------------------------------"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Configuring Remote Management - Complete"
echo "#------------------------------------------------------------------------------"
