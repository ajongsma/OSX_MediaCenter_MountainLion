#!/usr/bin/env bash

brew install mysql
unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

mkdir -p ~/Library/LaunchAgents
#cp /usr/local/Cellar/mysql/5.5.29/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
#launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

/usr/local/Cellar/mysql/5.5.29/bin/mysql_secure_installation

if [ ! -e $DIR/conf/my.conf ] ; then
	sudo cp $DIR/conf/my.conf /etc/my.cnf
else
	#sudo cp $(brew --prefix mysql)/support-files/my-small.cnf /etc/my.cnf
    sudo cp $(brew --prefix mysql)/support-files/my-medium.cnf /etc/my.cnf

    # https://newznab.readthedocs.org/en/latest/install/
    echo "-----------------------------------------------------------"
    echo "| Change the following information:"
    echo "| [mysqld]"
    echo "| ;max_allowed_packet = 1M"
    echo "| max_allowed_packet = 12582912"
    echo "| "
    echo "| ?? group_concat_max_len = 8192 ??"
    sudo subl /etc/my.cnf
fi

mysql.server start

mysql.server status
#sudo mkdir /var/mysql
#sudo ln -s /private/tmp/mysql.sock /var/mysql/mysql.sock