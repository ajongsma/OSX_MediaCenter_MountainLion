<?php
echo '<ul>';
	echo '<li><a href="includes/panels/remote.php" rel="ajaxpanel" data-loadtype="iframe">Remote</a></li>';
	if ($developer=="1") {
		echo '<li>';
		echo writeAppURL($CallHP_Mara,Int);
			echo '<ul>';
				echo '<li>';
				echo writeAppFull($CallHP_XBMC,XBMC);
				echo '</li>';
				echo '<li>';
				echo writeAppFull($CallHP_Plex,Plex);
				echo '</li>';
			echo '</ul>';
		echo '</li>';
	};
	if ($marahost!=="") {
		echo '<li>';
		echo writeAppURL($CallHP_Mara,Maraschino);
		echo '</li>';
	};
	echo '<li>';
		echo writeAppURL($CallHP_Mara,Downloaders);
		echo '<ul>';
			if ($sabnhost!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_Sab,SabNZBd);
				echo '</li>';
			};
			if ($utorhost!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_uTor,uTorrent);
				echo '</li>';
			};
			if ($tranhost!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_Tran,Transmission);
				echo '</li>';
			};
			if ($jDown!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_JDown,jDownloader);
				echo '</li>';
			};
		echo '</ul>';
	echo '</li>';
	if ($sickhost!=="") {
		echo '<li>';
		echo writeAppURL($CallHP_Sick,SickBeard);
		echo '</li>';
	};
	if ($couchost!=="") {
		echo '<li>';
		echo writeAppURL($CallHP_Couch,CouchPotato);
		echo '</li>';
	};
	if ($headhost!=="" || $subshost!=="") {
		echo '<li>';
			echo writeAppURL($CallHP_Mara,Music);
			echo '<ul>';
				if ($headhost!=="") {
					echo '<li>';
					echo writeAppFull($CallHP_Head,Headphones);
					echo '</li>';
				};
				if ($subshost!=="") {
					echo '<li>';
					echo writeAppFull($CallHP_Subs,SubSonic);
					echo '</li>';
				};
			echo '</ul>';
		echo '</li>';
	};
	if ($aumohost!=="" || $tvhehost!=="") {
		echo '<li>';
			echo writeAppURL($CallHP_Mara,Other);
			echo '<ul>';
				if ($aumohost!=="") {
					echo '<li>';
					echo writeAppFull($CallHP_AutoM,AutoMovies);
					echo '</li>';
				};
				if ($tvhehost!=="") {
					echo '<li>';
					echo writeAppFull($CallHP_TVHe,TVHeadend);
					echo '</li>';
				};
			echo '</ul>';
		echo '</li>';
	};
?>