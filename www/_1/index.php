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
			Something Something Bla Bla Bla
<?php
echo "php blaat<hr>";

$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=qstatus&output=json&apikey=".$sabnapi;
$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=queue&output=json&apikey=$sabnapi";

echo "<hr>";
echo "url :" . $url;
echo "<hr>";

$json = file_get_contents($url); $data = json_decode($json, TRUE);

$contents = file_get_contents($url);
$contents = json_decode($contents, true);
echo print_r($contents);
echo "<hr>";

echo var_dump($contents);
echo "<hr>";

$sab_state = $contents['queue']['status'];
echo "<hr>status: ".$sab_state;
echo "\t\t<div id=\"sab-header\">\n";
if (strtolower($state) == "downloading") {
	/*
	$ajaxurl = (!empty($_GET['style']) && ($_GET['style'] == "m") ? "index.php?w=wSabnzbd&" : "widgets/wSabnzbd.php?").(!empty($_GET['style']) ? "style=".$_GET['style']."&" : "")."c=".$count."&";
	$pathtoimages = ((!empty($_GET['style']) && (($_GET['style'] == "m") || ($_GET['style'] == "s"))) ? "../" : "./");

	$cmdPauseResume = $ajaxurl."cmd=pause";
	if(!empty($_GET['style']) && ($_GET['style'] == "w")) {
		echo "\t\t\t<p><a href=\"#\" onclick=\"cmdSabnzbd('".$cmdPauseResume."');\">$state</a>";
	} else {
		echo "\t\t\t<p><a href=\"".$cmdPauseResume."\" target=\"nothing\">$state</a>";
	}
	*/

	//href link is the resume URL for all the queue
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
	//href link is the pause URL for all the queue
	$cmdPauseResume = $ajaxurl."cmd=".((strtolower($state) == "paused") ? "resume" : "pause");
	if(!empty($_GET['style']) && ($_GET['style'] == "w")) {
		echo "\t\t\t<p><a href=\"#\" onclick=\"cmdSabnzbd('".$cmdPauseResume."');\">$state</a></p>\n";
	} else {
		echo "\t\t\t<p><a href=\"".$cmdPauseResume."\" target=\"nothing\">$state</a></p>\n";
	}
	echo "\t\t</div><!-- #sab-header -->\n";
}


//setup a few variables to use at the end
$sab_last_warning = $contents['queue']['last_warning'];
echo "<hr>sab_last_warning: ".$sab_last_warning;
$sab_version = $contents['queue']['version'];
echo "<hr>sab_version: ".$sab_version;
$sab_loadavg = $contents['queue']['loadavg'];
echo "<hr>sab_loadavg: ".$sab_loadavg;
echo "<hr>";

//use the array items from the json decoded object to create a basic status display
echo "<span id='sizeleft'>".$contents['queue']['sizeleft']."</span>/<span id='size'>".$contents['queue']['size']."</span> remaining @ <span id='speed'>".$contents['queue']['speed']."</span>/sec | ETA: <span id='eta'>".$contents['queue']['eta']."</span> (<span id='timeleft'>".$contents['queue']['timeleft']."</span>)";
echo "<br />";
echo "<strong>Speed Limit:</strong> <input type='text' id='speedlimit' style='width:50px;' value='".$contents['queue']['speedlimit']."' /><img src='img/accept.png' id='speedlimit_success' style='display:none;'/><br />";
echo "<a id='pause'>";
if($contents['queue']['paused']){ echo "Resume"; } else { echo "Pause"; }
echo "</a><br />";
echo "<a id='pgrefresh'>Refresh Page</a>";
echo "<span id='responsemessage' class='warningmessage' style='display:none;'></span><a id='responsemessage_hide' style='border-bottom:1px dotted red;display:none;font-size:80%;'>Clear</a>";


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