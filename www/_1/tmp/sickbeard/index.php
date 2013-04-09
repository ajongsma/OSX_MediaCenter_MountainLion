<?php
  require_once('functions.php');
  require('defaults.php');

## http://pooky.local:8081/api/404d0302b924328464f83a593a7d155c/?cmd=show.seasons&tvdbid=74608

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
    
    <title><?php echo $site_name . " v" . $version ?></title>
    <link rel="shortcut icon" href="../../img/favicon.ico" />
    <LINK href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id='site_content'>
    <center>
<?php

$apiURL = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=shows&sort=name&paused=0";
echo $apiURL."<br>";
$sbJSON_Shows = json_decode(file_get_contents($apiURL),true);
foreach ($sbJSON_Shows['data'] as $key => $values) {
	$showid = $values['tvdbid'];

	/* echo '<a href="seasonlist.php?showid=' . $values['tvdbid'] . '">' . $key . '</a><br />'; */

#============ (1 START) ----------------------------------------------------

    // Show URL
    $apiURL_sbSeasonList = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasonlist&tvdbid=".$showid."&sort=asc";
    $apiURL_sbShow = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show&tvdbid=".$showid;
    $apiURL_TraktTV = "http://api.trakt.tv/show/episode/summary.json/".$trakt_api."/".$showid."/1/1";

    // Fetch TraktTV api
    if ($trakt_enabled == "true") {
        $sbJSON = json_decode(file_get_contents($apiURL_sbSeasonList));
        $tvdata = json_decode(file_get_contents($apiURL_sbShow));
        
        $trakt = json_decode(file_get_contents($apiURL_TraktTV));
    } else {
        $sbJSON = json_decode(file_get_contents($apiURL_sbSeasonList));
        $tvdata = json_decode(file_get_contents($apiURL_sbShow));
    }
  
    // Grab Show Title
    $title = $tvdata->{data}->{show_name};
    
    echo "<h1>(1) ".$title."</h1>";

    if ($display_img_banners == "true") {	
    // Show Trakt.TV banner
        if ($trakt_enabled == "true") {
            if ($trakt->{status} == "failure") {
              // Show SickBeard Banner if trakt returned an error
              printf("<img src=http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.getbanner&tvdbid=".$showid."><br><br>");
            } else {
              // Show trakt.tv Bannger
              printf("<img src=".$trakt->{show}->{images}->{banner}."><br><br>");
            }
        } else {
            // Show SickBeard Banner
            printf("<img src=http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.getbanner&tvdbid=".$showid."><br><br>");
        }
    }
  
	if ($trakt_enabled == "true") {
		echo "<b>Year:</b> ".$trakt->{show}->{year}." | <b>Country:</b> ".$trakt->{show}->{country}."<br>";
		echo "<b>Network:</b> ".$trakt->{show}->{network}." | <b>Run Time:</b> ".$trakt->{show}->{runtime}." Mins<br>";
		echo "<b>Runs:</b> ".$trakt->{show}->{air_day}.", ".$trakt->{show}->{air_time}."<br>";
		echo "<b>Overview:</b> ".$trakt->{show}->{overview}."<br><br>";
	} else {
	// Show Sickbeard Next Episode
		if ($tvdata->{data}->{next_ep_airdate} == "") {
			$next_ep = "N/A";
		} else {
			$next_ep = $tvdata->{data}->{next_ep_airdate};
		}
	// Show Details Next Episode
		echo "Network: ".$tvdata->{data}->{network}.", Airs: ".$tvdata->{data}->{airs}.", Next Ep: ".$next_ep.", Show Status: ".$tvdata->{data}->{status}."<br><br>";
	}

	// Run through each feed item
	foreach($sbJSON->{data} as $show) {
	
	// Show Details
	if ($show == '0') {
		echo "<a href='episode.php?showid=".$showid."&seasonid=".$show."'>Specials </a><br />";
	} else {
		echo "<a href='episode.php?showid=".$showid."&seasonid=".$show."'>Season ".$show." </a><br />";
	}

#============ (2 START) ------------------------------------------------------
        $seasonid = $show;
        
        // Check if username is available, set URL
        $feed3_1 = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasons&tvdbid=".$showid."&season=".$seasonid;
        $feed3_2 = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show&tvdbid=".$showid;
        $feed3_3 = "http://api.trakt.tv/show/episode/summary.json/".$trakt_api."/".$showid."/1/1";
        echo $feed3_1."<br>";
        echo $feed3_2."<br>";
        echo $feed3_3."<br>";

        // fetch trakt api
        if ($trakt_enabled == "true") {
        	$sbJSON = json_decode(file_get_contents($feed3_1));
        	$tvdata = json_decode(file_get_contents($feed3_2));
        	$trakt = json_decode(file_get_contents($feed3_3));
        } else {
        	$sbJSON = json_decode(file_get_contents($feed3_1));
        	$tvdata = json_decode(file_get_contents($feed3_2));
        }

        // Grab Show Title
        $title = $tvdata->{data}->{show_name};
    
echo "<table>";
echo "  <tr>";
echo "    <td>";
echo "      <h1>".$title." Season ".$seasonid."</h1>";
echo "    </td>";
echo "  </tr>";
echo "  <tr>";

	// Define episode counter
	$counter = "1";

	// Run through each feed item
	foreach($sbJSON->{data} as $show) {
      // Show Details
echo "    <td>";
echo "      <a href='epdata.php?showid=".$showid."&seasonid=".$seasonid."&ep=".$counter."'><b>Episode:</b> " . $counter . "</a><br />";
echo "    </td>";
echo "    <td>";
            echo "<b>Name:</b> " . $show->{name} . "<br />";
echo "    </td>";
echo "    <td>";
            echo "<b>Aired:</b> " . $show->{airdate} . "<br />";
echo "    </td>";
echo "    <td>";
            if ($show->{status} == "Archived")
            {
              echo "<font color='#41A317'><b>Status:</b> Collected </font><br /><br />";
            } 
            elseif ($show->{status} == "Snatched")
            {
              echo "<font color='#41A317'><b>Status:</b> Downloading... </font><br /><br />";
            }
            elseif ($show->{status} == "Downloaded")
            {
              echo "<font color='#41A317'><b>Status:</b> Collected </font><br /><br />";
            }
            elseif ($show->{status} == "Wanted")
            {
              echo "<font color='#306EFF'><b>Status:</b> Wanted </font><br /><br />";
            } 
            else
            {
              echo "<font color='#F62817'><b>Status:</b> Not Collected </font><br /><br />";
            }
            $counter = $counter + "1";
        }

echo "    </td>";
echo "  </tr>";
echo "</table>";
#============ (2 END) ------------------------------------------------------
    }

#============ (1 END) ---------------------------------------------------
}


?>
	</div>
</body>
</html>
