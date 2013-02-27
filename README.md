OSX_NewBox
==========

Shell scripts are currently used as a guideline document and should not be run as an install script.

<hr>

# SETUP
* OS X Mountain Lion
  * Updated GNU core utilities (coreutils)
  * apple-gcc42
  * gnu-sed
  * autoconf
  * automake
  * findutils
  * bash
  * wget
  * texi2html
  * yasm
  * x264
  * faac
  * lame
  * xvid
  * ffmpeg
  * mediainfo
* [Xcode](http://itunes.apple.com/us/app/xcode/id497799835?mt=12)
* [Xcode Command Line Tools] (https://developer.apple.com/)
* [Xquartz] (http://xquartz.macosforge.org/landing)
* [OSX Server 2.0](https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12)
  * Apache
* [Sublime Text 2](http://www.sublimetext.com)
* [iTerm 2](http://http://www.iterm2.com)
  * [Solarized for iTerm 2] (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)
* [Xlog](https://itunes.apple.com/us/app/xlog/id430304898?mt=12&ls=1)
* [Tmux](http://tmux.sourceforge.net/)
  ~ ([Tmux crashcourse] (http://robots.thoughtbot.com/post/2641409235/a-tmux-crash-course))
* [Github for Mac](http://mac.github.com)
* [Dropbox] (http://www.dropbox.com/download?plat=mac)
* Powerline
* PHP 5.4
* Python
* Pear
* MySQL
  * [MySQL Workbench] (http://dev.mysql.com/downloads/workbench)
* PostgreSQL
  * [pgadmin] (http://www.pgadmin.org/download/macosx.php)
  * [InductionApp] (http://inductionapp.com)
* [HomeBrew] (http://mxcl.github.com/homebrew/)
* [NewzNAB] (http://www.newznab.com/) ``` [NewzNAB Forum] (http://http://www.newznabforums.com) ```
  * [jonnyboy/newznab-tmux] (https://github.com/jonnyboy/newznab-tmux)
  * [Newzdash (NewzNab dashboard)] (https://github.com/tssgery/newzdash)
* [Sphinx] (http://www.sphinxsearch.com/downloads.html)
* [SpotWeb] (https://github.com/spotweb/spotweb/wiki)
* [SabNZBD] (http://sabnzbd.org/)
  * [nzbToMedia] (https://github.com/clinton-hall/nzbToMedia)
* [Cheetah] (http://www.cheetahtemplate.org/download)
* [SickBeard] (http://sickbeard.com/)
  * NewzNAB as a Newznab Provider
  * Spotweb as a Newznab Provider
  * [TraktTV integration] (https://trakt.tv/)
* [Auto-Sub] (http://code.google.com/p/auto-sub/)
* [Couch Potato] (https://couchpota.to/)
  * NewzNAB as a Newznab Provider
  * Spotweb als Newznab Provider
  * [TraktTV integration] (https://trakt.tv/)
* [Periscope] (http://code.google.com/p/periscope/)
* [Headphones] (https://github.com/rembo10/headphones)
  * NewzNAB as a Newznab Provider
  * Spotweb als Newznab Provider
* [Maraschino] (http://www.maraschinoproject.com/)
  ``` [Maraschino Forum] (http://forums.maraschinoproject.com) ```
* [Plex] (http://www.plexapp.com/)
  * [Plex Media Server] (http://plex.r.worldssl.net/PlexMediaServer/0.9.7.12.407-db37d6d/PlexMediaServer-0.9.7.12.407-db37d6d-OSX.dmg)
  * [Plex Media Center Client] (http://www.plexapp.com/download/plex-media-center.php)
  * [Plex Mobile] (http://www.plexapp.com/ios.php)


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
  mysqldump --opt -u root -p <password> ~/mysql_backup.sql
  ```

<hr>

# TO CHECK OUT
* [Article: The Text Triumvirate] (http://www.drbunsen.org/text-triumvirate.html#tmux)
* [Article: Tmux and Vim, get married] (http://thedrearlight.com/blog/tmux-vim.html)
* Powerline
  * [Powerline - Tmux] (https://github.com/erikw/tmux-powerline)
  * [Powerline - Vim : Readme] (https://github.com/Lokaltog/vim-powerline/blob/develop/doc/Powerline.txt)
  * [Powerline - Vim] (https://github.com/Lokaltog/vim-powerline)
  * [Powerline style prompt for Bash] (https://github.com/milkbikis/powerline-shell)
  * [Powerline - oh-my-zsh] (https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme)
* [Solarized] (http://ethanschoonover.com/solarized)
  * [HowTo] (http://blog.likewise.org/2012/04/how-to-set-up-solarized-color-scheme.html)
  * [Solarized iTerm 2] (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)
* Bash Completion
* Ruby
* [GeekTool] (http://projects.tynsoe.org/en/geektool)
  * http://lifehacker.com/5834676/build-an-attractive-informative-mac-desktop-with-geektool
  * http://mac.appstorm.net/roundups/utilities-roundups/over-46-powerful-geeklets-and-scripts-for-the-geek-within-you/
  * http://mac.tutsplus.com/tutorials/customization/5-ways-to-make-your-macs-desktop-better-with-geektool/
* NewzNAB
  * [NewzNAB - Custom Content Page - Mini NZB Feed Compare] (http://www.newznabforums.com/index.php?topic=623.0)
  * [Baffi-Theme] (https://github.com/Frikish/Baffi-Theme--Newznab-)
  * [Post Processing script: Auto release assembler suite] (http://www.newznabforums.com/index.php?topic=631.msg5625#msg5625)
  * RegEx ``` a.b.teevee ```
  ``` Disable all except: /^(\[|)(?P<name>.*?)(\]|) (\- |)\[(?P<parts>\d{1,3}\/\d{1,3})\] \- \".*?xvid.*?\"/i ```
  ``` Add - Category 1080p WEB-DL (Ordinal 2): /^(RE\: |)\[.*?\](\-\[FULL\]|)\-\[\#.*?\](\-\[FULL\]|)\-\[(?P<name>.*?(1080[a-zA-Z].WEB.DL).*?)\]( |)\-\[(?P<parts>\d{1,3}\/\d{1,3})\]/ ```
  ``` Add - Category 720p WEB-DL (Ordinal 3): /^(RE\: |)\[.*?\](\-\[FULL\]|)\-\[\#.*?\](\-\[FULL\]|)\-\[(?P<name>.*?(720[a-zA-Z].WEB.DL).*?)\]( |)\-\[(?P<parts>\d{1,3}\/\d{1,3})\]/ ```
  ``` Add - Category HD (Ordinal 4): /^(RE\: |)\[.*?\](\-\[FULL\]|)\-\[\#.*?\](\-\[FULL\]|)\-\[(?P<name>.*?(720[a-zA-Z].HDTV.[a-zA-Z]264).*?)\]( |)\-\[(?P<parts>\d{1,3}\/\d{1,3})\]/ ```
  ``` Add - Category SD (Ordinal 5): /^(RE\: |)\[.*?\](\-\[FULL\]|)\-\[\#.*?\](\-\[FULL\]|)\-\[(?P<name>.*?(HDTV.[a-zA-Z]264).*?)\]( |)\-\[(?P<parts>\d{1,3}\/\d{1,3})\]/ ```
  * Blacklist:
  ``` fina|wrestling|nba|mma|Croatian|Spanish|Turkish|TNA|NFL|WWE|EPL|National.Geographic|wtcc|nba|olympics|xxx|german|danish|flemish|dutch|french|swedish|swesub|deutsch|nl\.?sub|norwegian|\.ita\. FR|DE|ITA|sie|seit|ihn|ihm|haben|besitzen|sein|kriegen|nehmen|welche|jenes|von|auf|gegen|nach|das|sein|der|und|fuer|ersten|leicht|meinem|zum|aus|dem|blitzlicht|alle|grosse|zed|ich|sed|blitzen|NCAA Basketball ```

