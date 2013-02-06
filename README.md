OSX_NewBox
==========

# LINKS

https://github.com/jonnyboy/newznab-tmux

<hr>

# SETUP

* OSX Server 2.0
  * Apache
* PHP 5.4
* Brew
* NewzNAB
* SpotWeb
* SabNZBD
* Sick-Beard
* Couch Potato
* Marachino
* 



# ADDENDUM


* NewzNAB processing: https://github.com/jonnyboy/newznab-tmux
 * tmux 1.6 or newer is needed to runs these scripts. This script relies on tmux reporting that the "Pane is dead". That is how the script knows that is nothing running in that pane and to restart it for another loop. Seeing "Pane is dead" is normal and expected.
 * [jonnyboy - Newznab-tmux](https://github.com/jonnyboy/newznab-tmux)
 * To exit the jonnyboy scripts without any worry of causing problems. Click into the Monitor pane, top left and Ctrl-c, or edit defaults.sh and set running="false". This will stop the monitor script. When all of the other panes show dead, then it is ok to run Ctrl-a c and in new window run killall tmux.
   Take caution that Optimize is not running when you shut down the scripts, Optimize runs in window 2, pane 4.

    ```bash
    cd /User/Newznab/Sites/newznab/update_scripts/nix-scripts/tmux/ && ./start.sh
    ```


# OTHER INFO


* If needed, backup the MySQL database:
 
  ```bash
  mysqldump --opt -u root -p newznab > ~/newznab_backup.sql
  ```

<hr>

