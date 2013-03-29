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
			<?php require 'includes/widgets/sabnzbd_download.php'; ?>
			<?php require 'includes/widgets/sabnzbd_history.php'; ?>
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