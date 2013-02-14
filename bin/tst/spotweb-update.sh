#!/bin/sh
# Upgrade script voor Spotweb.
#
# Eerst testen of het proces nog niet draait.
# Dit doe ik aan de hand van het bestaan van een tempfile.
if [ -f /tmp/.spotweb-upgrade ]
then
echo "==> Update Spotweb already started..."
# Stoppen met verdere update aangezien de file al aanwezig is.
exit
fi
# Tempfile aanmaken aangezien de update nog niet draait
touch /tmp/.spotweb-upgrade
wait
echo "==> Updating Spotweb..."
cd /Users/Spotweb/Sites/spotweb
git pull
echo "Waiting for completing GIT pull..."
wait
echo "==> Starting database upgrade..."
/usr/bin/php upgrade-db.php
wait
# Tempfile weer opruimen, anders wordt er maar eenmalig ge-upgrade.
rm /tmp/.spotweb-upgrade

## ***
## #!/bin/sh
## # Alternatief upgrade script voor Spotweb. 
## # Plaats het script in root van Spotweb en maak een cron aan.
## #
## echo "Spotweb updaten..."
## git pull
## wait
## echo "Database upgrade..."
## # Command om php locatie te bepalen: "which php"
## /usr/bin/php upgrade-db.php
## wait
## echo "Spotweb is geupdate!"
## ***