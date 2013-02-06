OSX_NewBox
==========

# LINKS

https://github.com/jonnyboy/newznab-tmux

<hr>

# SETUP



# ADDENDUM

* tmux 1.6 or newer is needed to runs these scripts. This script relies on tmux reporting that the "Pane is dead". That is how the script knows that is nothing running in that pane and to restart it for another loop. Seeing "Pane is dead" is normal and expected.

* NewzNAB processing: https://github.com/jonnyboy/newznab-tmux

 * [jonnyboy - Newznab-tmux](https://github.com/jonnyboy/newznab-tmux)
 * To exit the jonnyboy scripts without any worry of causing problems. Click into the Monitor pane, top left and Ctrl-c, or edit defaults.sh and set running="false". This will stop the monitor script. When all of the other panes show dead, then it is ok to run Ctrl-a c and in new window run killall tmux.

  ```bash
  cd ../ && ./start.sh
  ```


# OTHER INFO


* If needed, backup the MySQL database:
 
  ```bash
  mysqldump --opt -u root -p newznab > ~/newznab_backup.sql
  ```


 * Run my script, as user. There are many parts that require sudo or root, especially if you have grsec compliled into the kernel. I have put checks in that will require elevated priviledges.

  ```bash
  cd ../ && ./start.sh
  ```

 * Several commands require root priviledges, such as editing files, chmod the paths, creating the ramdisk. If you have grsec compiled into your kernel, you will also need root priviledges for nmon and any other network monitoring app.

 * Additional scripts included in the script folder. I have included prepare.sh to make updating these scripts a little easier. I also included an svn updater, update_svn.sh. It performs a forced svn update, which overwrites any changes you may have may to the stock nn+ scripts and the updates the database. Also, included is revert.sh. This file removes the changes made to postprocess.sh and you need to run this before running stock update_releases.php.
 
 * Any variable in defaults.sh can be changed, except the paths to the commands, and the changed will take effect on the next loop of the monitor. By default, the monitor loops every 30 seconds

 * If you connect using **putty**, then under Window/Translation set Remote character set to UTF-8. To use 256 colors, you must set Connection/Data Terminal-type string to "xterm-256color" and in Window/Colours check the top three boxes, otherwise only 16 colors are displayed.
 
 * If you are using the powerline statusbar, you will most likely need a patch font. The Consolas ttf from [powerline-fonts](https://github.com/jonnyboy/powerline-fonts) is the only one that I have found to be nearly complete and work with putty and Win7. The otf fonts should be fine, although I am not able to test.

 * You must edit any file that is called from **misc/testing/** in order for it to actually do something, and update_parsing is good for fixing a few releases everytime it runs, not a silver bullet though.

 * Take caution that Optimize is not running when you shut down the scripts, Optimize runs in window 2, pane 4.

 * Before submitting a bug report, please verify that you are running the current revision of nn+ and these scripts. Then include as much detail as possible.

 * Some scripts written by [cj](https://github.com/NNScripts/nn-custom-scripts) can help cleanup your db and remove unlinked parts. Another script [nevermind](http://pastebin.com/ibpi71iE) will help your db run a little faster/easier.

 * Join in the converstion at irc://irc.synirc.net/newznab-tmux.




 * Thanks go to all who offered their assistance and improvement to these scripts, especially kevin123, zombu2, epsol, DejaVu, ajeffco, pcmerc, zDefect, shat, evermind, coolcheat, sy, ll, crunch, ixio, AlienX, Solution-X, cryogenx, convict, wicked, McFuzz, pyr2044 and Kragger. If, your nick is missing from this this, PM and I'll fix it quick.
 
 * These scripts include scripts written by [kevin123's](https://github.com/kevinlekiller), [itandrew's](https://github.com/itandrew/Newznab-InnoDB-Dropin), [tmux-powerline](https://github.com/erikw/tmux-powerline) and [thewtex](git://github.com/thewtex/tmux-mem-cpu-load.git).

<hr>
![Newznab-tmux](https://raw.github.com/jonnyboy/newznab-tmux/master/images/newznab-tmux.png)


