<?php
	require 'includes/required/errorreporting.php';
	require 'includes/required/defaults.php';
?>

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="HandheldFriendly" content="True">
	<meta name="MobileOptimized" content="320"/>
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta http-equiv="cleartype" content="on">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

	<title>Portal v<?php echo $version ?></title>
	<link rel="shortcut icon" href="img/favicon.ico" />

	<!--Include JQM and JQ-->
	<link rel="stylesheet" href="css/themes/jqmfb.min.css" />
	<link rel="stylesheet" href="http://code.jquery.com/mobile/latest/jquery.mobile.structure.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
	<script src="js/jquery.animate-enhanced.min.js"></script>

	<!--JQM globals you can edit or remove file entirely... note it needs to be loaded before jquerymobile js -->
	<script src="js/jqm.globals.js"></script>

	<script src="http://code.jquery.com/mobile/latest/jquery.mobile.min.js"></script>

	<!--TESTING -->
	<link rel="stylesheet" href="css/test.css" />

	<!--JQM SlideMenu-->
	<link rel="stylesheet" href="css/jqm.slidemenu.css" />
	<script src="js/jqm.slidemenu.js"></script>
</head>
<body>
	<div id="slidemenu">

		<div id="profile">
			<h1>&nbsp;Portal</h1>
		</div>

		<h3>MENU</h3>
		<ul>
			<li><a href="#main_page"><img src="img/menu_star.png">Home</a></li>
			<li><a href="#main_page"><img src="img/menu_person.png">Something</a></li>
			<li><a href="#main_page"><img src="img/menu_config.png">Something</a></li>
			<li><a href="#main_page" rel="external"><img src="img/menu_heart.png">Something</a></li>
		</ul>

		<h3>INDEXERS</h3>
		<ul>
			<li><a href="#NewzNAB"><img src="img/menu_star.png">NewzNAB</a></li>
			<li><a href="#SpotWeb"><img src="img/menu_star.png">SpotWeb</a></li>
		</ul>

		<h3>DOWNLOADERS</h3>
		<ul>
			<li><a href="#SabNZBD"><img src="img/menu_star.png">SabNZBD</a></li>
		</ul>

		<h3>TV SHOWS</h3>
		<ul>
			<li><a href="#Sickbeard"><img src="img/menu_star.png">Sickbeard</a></li>
		</ul>

		<h3>MOVIES</h3>
		<ul>
			<li><a href="#CouchPotato"><img src="img/menu_star.png">CouchPotato</a></li>
		</ul>

		<h3>MUSIC</h3>
		<ul>
			<li><a href="#HeadPhones"><img src="img/menu_star.png">Headphones</a></li>
		</ul>

		<h3>MEDIA SERVERS</h3>
		<ul>
			<li><a href="#Plex"><img src="img/menu_star.png">Plex</a></li>
		</ul>

	</div>


	<div data-role="page" id="main_page" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Main page</h1>
		</div>
		<div data-role="content">
<?php
/* 
$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=queue&output=json&apikey=$sabnapi";
$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=qstatus&output=json&apikey=$sabnapi";
$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=history&limit=50&output=json&apikey=$sabnapi";
*/

/* DOWNLOAD PAUSED 
$contents = '{"queue":{"active_lang":"en","session":"062df8bae5c1b9434b51914ae0ac3684","slots":[{"status":"Checking","index":0,"eta":"unknown","missing":0,"avg_age":"68d","script":"nzbToSickBeard.py","msgid":"","verbosity":"","mb":"13361.82","sizeleft":"9.3 GB","filename":"jF7HBtfIY3CG","priority":"Normal","cat":"tv","mbleft":"9502.00","timeleft":"0:00:00","percentage":"28","nzo_id":"SABnzbd_nzo_bxZEoR","unpackopts":"3","size":"13.0 GB"}],"speed":"0 ","size":"13.0 GB","limit":0,"start":0,"diskspacetotal2":"464.96","darwin":true,"last_warning":"2013-03-26 20:08:56,360\nWARNING:\nAPI Key missing, please enter the api key from Config->General into your 3rd party program: ::1>??","have_warnings":"13","noofslots":1,"newzbin_url":"www.newzbin2.es","pause_int":"0","categories":["*","anime","apps","books","consoles","games","movies","music","pda","tv"],"diskspacetotal1":"464.96","mb":"13361.82","loadavg":"","cache_max":"209715200","speedlimit":"","webdir":"","left_quota":"0 ","uniconfig":"/Applications/SABnzbd.app/Contents/Resources/interfaces/Config/templates","paused":true,"isverbose":false,"restart_req":false,"power_options":true,"helpuri":"http://wiki.sabnzbd.org/","uptime":"2d","refresh_rate":"","my_home":"/Users/Andries","version":"0.7.11","my_lcldata":"/Users/Andries/Library/Application Support/SABnzbd","color_scheme":"Gold","new_release":"","nt":false,"status":"Paused","finish":0,"cache_art":"0","paused_all":false,"finishaction":null,"sizeleft":"9.3 GB","quota":"0 ","cache_size":"0 B","mbleft":"9502.00","diskspace2":"254.50","diskspace1":"254.50","scripts":["None","autoProcessMovie.py","autoProcessTV.py","nzbToCouchPotato.py","nzbToMediaEnv.py","nzbToSickBeard.py","TorrentToMedia.py"],"timeleft":"0:00:00","have_quota":false,"nzb_quota":"","eta":"unknown","kbpersec":"0.00","new_rel_url":"","queue_details":"0"}}';
*/

/* DOWNLOAD ACTIVE 
$contents = '{"queue":{"active_lang":"en","session":"062df8bae5c1b9434b51914ae0ac3684","slots":[{"status":"Checking","index":0,"eta":"unknown","missing":0,"avg_age":"68d","script":"nzbToSickBeard.py","msgid":"","verbosity":"","mb":"13361.82","sizeleft":"7.8 GB","filename":"FILENAME","priority":"Normal","cat":"tv","mbleft":"7945.56","timeleft":"0:00:00","percentage":"40","nzo_id":"SABnzbd_nzo_bxZEoR","unpackopts":"3","size":"13.0 GB"}],"speed":"5 K","size":"13.0 GB","limit":0,"start":0,"diskspacetotal2":"464.96","darwin":true,"last_warning":"2013-03-26 20:08:56,360\nWARNING:\nAPI Key missing, please enter the api key from Config->General into your 3rd party program: ::1>??","have_warnings":"13","noofslots":1,"newzbin_url":"www.newzbin2.es","pause_int":"0","categories":["*","anime","apps","books","consoles","games","movies","music","pda","tv"],"diskspacetotal1":"464.96","mb":"13361.82","loadavg":"","cache_max":"209715200","speedlimit":"","webdir":"","left_quota":"0 ","uniconfig":"/Applications/SABnzbd.app/Contents/Resources/interfaces/Config/templates","paused":false,"isverbose":false,"restart_req":false,"power_options":true,"helpuri":"http://wiki.sabnzbd.org/","uptime":"2d","refresh_rate":"","my_home":"/Users/Andries","version":"0.7.11","my_lcldata":"/Users/Andries/Library/Application Support/SABnzbd","color_scheme":"Gold","new_release":"","nt":false,"status":"Downloading","finish":0,"cache_art":"0","paused_all":false,"finishaction":null,"sizeleft":"7.8 GB","quota":"0 ","cache_size":"0 B","mbleft":"7945.56","diskspace2":"254.50","diskspace1":"254.50","scripts":["None","autoProcessMovie.py","autoProcessTV.py","nzbToCouchPotato.py","nzbToMediaEnv.py","nzbToSickBeard.py","TorrentToMedia.py"],"timeleft":"459:08:51","have_quota":false,"nzb_quota":"","eta":"00:17 Wed 17 Apr","kbpersec":"4.92","new_rel_url":"","queue_details":"0"}}';
*/


/* DOWNLOAD ACTIVE
$contents = '{"have_warnings":"0","pp_active":false,"noofslots":1,"paused":true,"pause_int":"0","mbleft":1605.749349,"diskspace2":243.016285,"diskspace1":243.016285,"jobs":[{"timeleft":"0:00:00","mb":1788.982698,"msgid":"","filename":"Arrow S01E18 1080p WEB-DL DD5 1 H 264-BS","mbleft":1605.749349,"id":"SABnzbd_nzo_pGJoAs"}],"speed":"0 ","timeleft":"0:00:00","mb":1788.982698,"state":"Paused","loadavg":"","kbpersec":0.000000}';
*/

/* DOWNLOAD PAUSED 
$contents = 
'{"have_warnings":"0","pp_active":false,"noofslots":1,"paused":false,"pause_int":"0","mbleft":1462.141112,"diskspace2":243.016376,"diskspace1":243.016376,"jobs":[{"timeleft":"69:58:35","mb":1788.982698,"msgid":"","filename":"Arrow S01E18 1080p WEB-DL DD5 1 H 264-BS","mbleft":1462.141112,"id":"SABnzbd_nzo_pGJoAs"}],"speed":"6 K","timeleft":"69:58:35","mb":1788.982698,"state":"Downloading","loadavg":"","kbpersec":5.943388}';
*/

$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=qstatus&output=json&apikey=$sabnapi";
$json = file_get_contents($url);
$data = json_decode($json, TRUE);
$contents = file_get_contents($url);
$contents = json_decode($contents, true);

/* download status ('Completed', 'Paused', 'Queued, 'Failed', 'Verifying', 'Downloading', 'Extracting') */
$sab_state = $contents['state'];
if (strtolower($sab_state) == "idle") {
	echo "==>Check state: idle<br>";

} else {
	$sab_Speed = $contents['speed'];
	$sab_filename = $contents['jobs']['0']['filename'];
	
	if($sab_filename) {
		$sab_QueueMBTotal = round($contents['mb']);                            # Get size of queue
		$sab_QueueMBLeft = round($contents['mbleft']);                    # Get how much is left of queue
		$sab_QueueMBDone = round($sab_QueueMBTotal - $sab_QueueMBLeft);                 # Calculate how much has been downloaded
		$sab_QueueProgress = round((($sab_QueueMBDone / $sab_QueueMBTotal) * 100),2);  # Calculate percentage downloaded
	}

	echo "<div class='downloadFrame clearfix'>";
	echo "	<div class='downloadPage downloadPageCurrent'>";
	echo "		<h2>" . $sab_state . "</h2>";
	echo "		<span class='currentdl'>" . $sab_filename . "</span>";
	echo "		<progress value='".$sab_QueueMBDone."' max='".$sab_QueueMBTotal."'></progress><span class='stats'>".$sab_QueueMBDone." / ".$sab_QueueMBTotal."mb (".$sab_QueueProgress."%) @ ".$sab_Speed."M</span>";
	echo "	</div>";
	echo "</div>";
}

echo "<hr>";

/*
echo "\t\t<div id=\"sab-header\">\n";
if (strtolower($state) == "downloading") {
	echo "=>Check state: Downloading<br>";

	//href link is the resume URL for all the queue
	$sab_filename = $contents['queue']['filename'];
	$sab_speed = $contents['queue']['speed'];
	$sab_timeleft = $contents['queue']['timeleft'];
	echo " - Speed: ".$sab_speed." - Timeleft: ".$sab_timeleft."</p>\n";

	$sab_totalQ = (int)$contents['queue']['mb'];
	$sab_remainingQ = (int)$contents['queue']['mbleft'];
	if($sab_totalQ!=0){
		$sab_percentageQ = (int)((($sab_totalQ - $sab_remainingQ) / $sab_totalQ)*100);
		//Total progress bar with Time Left and MB left/ MB remainig as you can see from previous posts. It only shows up when the queue is not paused
		echo "\t\t\t<div id=\"sab-total\" class=\"progressbar\"><div class=\"progress\" style=\"width:".$sab_percentageQ."%\"></div><div class=\"progresslabel\">".$contents['queue']['sizeleft']." / ".$contents['queue']['size']."</div></div>\n";
	}
} else {
	echo "=>Check state: Else<br>";
}

//use the array items from the json decoded object to create a basic status display
echo "<span id='sizeleft'>".$contents['queue']['sizeleft']."</span>/<span id='size'>".$contents['queue']['size']."</span> remaining @ <span id='speed'>".$contents['queue']['speed']."</span>/sec | ETA: <span id='eta'>".$contents['queue']['eta']."</span> (<span id='timeleft'>".$contents['queue']['timeleft']."</span>)";
echo "<br />";
echo "<strong>Speed Limit:</strong> <input type='text' id='speedlimit' style='width:50px;' value='".$contents['queue']['speedlimit']."' /><img src='img/accept.png' id='speedlimit_success' style='display:none;'/><br />";
echo "<a id='pause'>";
if($contents['queue']['paused']){ echo "Resume"; } else { echo "Pause"; }
echo "</a><br />";
echo "<a id='pgrefresh'>Refresh Page</a>";
echo "<span id='responsemessage' class='warningmessage' style='display:none;'></span><a id='responsemessage_hide' style='border-bottom:1px dotted red;display:none;font-size:80%;'>Clear</a>";
/*




?>

		</div>
	</div>

	<div data-role="page" id="NewzNAB" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Indexers</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost/newznab" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:1px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>

	<div data-role="page" id="SpotWeb" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Indexers</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost/spotweb" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>

	<div data-role="page" id="SabNZBD" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Download</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost:8080" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>

	<div data-role="page" id="Sickbeard" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>TV Shows</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost:8081" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>

	<div data-role="page" id="CouchPotato" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Movies</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost:8082" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>

	<div data-role="page" id="HeadPhones" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Music</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost:8085" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>

	<div data-role="page" id="Plex" data-theme="a">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" data-update-page-padding="false">
			<a href="#" data-slidemenu="#slidemenu" data-slideopen="false" data-icon="smico" data-corners="false" data-iconpos="notext">Menu</a>
			<h1>Music</h1>
		</div>
		<div data-role="content">
			<iframe src="http://localhost:32400/web" width="100%" height="700" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
			</iframe>
		</div>
	</div>


</body>
</html>