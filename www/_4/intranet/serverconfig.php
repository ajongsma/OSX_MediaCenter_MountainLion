<?php 
	$config = array(

		# Services
		# Set these to false to disable them
		"sickbeard" => true,
		"couchpotato" => false,
		"headphones" => true,
		"sabnzbd" => true,
		"uTorrent" => false,
		"transmission" => false,

		# URLs and Ports
		"sickbeardURL" => "localhost",
		"sickbeardPort" => "8081",
		"sickbeardAPI" => "404d0302b924328464f83a593a7d155c",
		"sickbeardHTTPS" => false,
		"sabnzbdURL" => "localhost",
		"sabnzbdPort" => "8080",
		"sabnzbdAPI" => "062df8bae5c1b9434b51914ae0ac3684",
		"sabnzbdHTTPS" => false,
		"couchpotatoURL" => "localhost",
		"couchpotatoPort" => "8082",
		"couchpotatoHTTPS" => false,
		"headphonesURL" => "localhost",
		"headphonesPort" => "8084",
		"headphonesHTTPS" => false,
		"uTorrentURL" => "localhost",
		"uTorrentPort" => "8089",
		"transmissionURL" => "localhost",
		"transmissionPort" => "9091",

		# Usernames and Passwords
		# If not using usernames or passwords, leave these to false.
		# ie. "sickbeardUsername" => false,
		"sickbeardUsername" => false,
		"sickbeardPassword" => false,
		"sabnzbdUsername" => "admin",
		"sabnzbdPassword" => "admin",
		"uTorrentUsername" => "admin",
		"uTorrentPassword" => "admin",
		"transmissionUsername" => false,
		"transmissionPassword" => false,

		# Sickbeard - Missed or Coming?
		# Australia, for example, is almost an entire day ahead of America so American TV shows 
		# air the day after they say they're going to air, so instead of "coming shows", we use "missed shows"
		# to indicate what's coming out today. 
		# Set to true for "missed", false for "coming"
		"sickMissed" => true,

		# Show popups when hovering over coming shows?
		"sickPopups" => true,

		# Debug
		"debug" => false,

		# Show trailers button
		"showTrailers" => true,

		# Wifi
		# WifiName is also used for page title
		"showWifi" => true,
		"wifiName" => "Home Network",
		"wifiPassword" => "abcd1234",

		# Bookmarks
		"bookmarks" => array(
			0 => array(
				"label" => "NZBMatrix",
				"url" => "http://www.nzbmatrix.com",
			),
			1 => array(
				"label" => "Season Start Dates",
				"url" => "intranet/comingseasons.php",
				"icon" => "intranet/images/tv.png",
			),
		),

	);
?>