<?php
echo '<ul>';
	echo '<li><a href="includes/panels/remote.php" rel="ajaxpanel" data-loadtype="iframe">Remote</a></li>';
	echo '<li>';
	if ($xbmchost!=="" || $plexhost!=="") {
		echo writeAppURL($CallHP_Mara,'Media Server');
			echo '<ul>';
				if ($xbmchost!=="") {
					echo '<li>';
					echo writeAppFull($CallHP_XBMC,XBMC);
					echo '</li>';
				};
				if ($plexhost!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_Plex,Plex);
				echo '</li>';
				};
			echo '</ul>';
		echo '</li>';
	};

	if ($marahost!=="") {
		echo '<li>';
		echo writeAppURL($CallHP_Mara,Maraschino);
		echo '</li>';
	};

	if ($spothost!=="" || $newzhost!=="") {
	echo '<li>';
		echo writeAppURL($CallHP_Indx,Indexers);
		echo '<ul>';
			if ($spothost!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_Spot,SpotWeb);
				echo '</li>';
			};
			if ($newzhost!=="") {
				echo '<li>';
				echo writeAppFull($CallHP_newz,NewzNAB);
				echo '</li>';
			};
		echo '</ul>';
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