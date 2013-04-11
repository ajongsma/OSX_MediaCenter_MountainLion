<?php
  require('includes/required/defaults.php');
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
  <link href="includes/css/default_sb.css" rel="stylesheet" type="text/css">
  <link href="includes/css/table.css" rel="stylesheet" type="text/css">
</head>
<body>
  <div id='site_content'>
    <center>
<?php

if(empty($sickbeard_api)) {
	echo "<hr><h1><font color='#F62817'><b>ERROR: Sick-Beard API value is not provided</b></font></h1><hr>";
}
if(($trakt_enabled == "true") && empty($trakt_api)) {
	echo "<hr><h1><font color='#F62817'><b>ERROR: Trakt is enabled but the API value is not provided</b></font></h1><hr>";
}

if ($display_Sickbeard_StatsTotal == "true") {
  $apiURL_sbStatsTotal = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=shows.stats";
  echo "apiURL_sbStatsTotal : ".$apiURL_sbStatsTotal;
  $sbJSON_StatsTotal = json_decode(file_get_contents($apiURL_sbStatsTotal));
  echo "<br>Eps Downloaded: ".$sbJSON_StatsTotal->{data}->{ep_downloaded}." of ".$sbJSON_StatsTotal->{data}->{ep_total}." == Shows Active: ".$sbJSON_StatsTotal->{data}->{shows_active}." of ".$sbJSON_StatsTotal->{data}->{shows_total}."<br><br>";
}

$apiURL = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=shows&sort=name&paused=0";
if ($debug == "true") {
	echo $apiURL."<br>";
}

$sbJSON_Shows = json_decode(file_get_contents($apiURL),true);
foreach ($sbJSON_Shows['data'] as $key => $values) {
	$showid = $values['tvdbid'];

	/* echo '<a href="seasonlist.php?showid=' . $values['tvdbid'] . '">' . $key . '</a><br />'; */

  if ($display_Sickbeard_StatsShow == "true") {
    $apiURL_sbShowTotal = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.stats&tvdbid=".$showid;
    echo "apiURL_sbShowTotal : ".$apiURL_sbShowTotal."<br>";

    $sbJSON_ShowTotal = json_decode(file_get_contents($apiURL_sbShowTotal));
    echo "<hr>";
    echo "Total      : ".$sbJSON_ShowTotal->{data}->{total}."<br>";
    echo "Archived   : ".$sbJSON_ShowTotal->{data}->{archived}."<br>";
    echo "ignored    : ".$sbJSON_ShowTotal->{data}->{ignored}."<br>";
    echo "skipped    : ".$sbJSON_ShowTotal->{data}->{skipped}."<br>";
    echo "unaired    : ".$sbJSON_ShowTotal->{data}->{unaired}."<br>";
    echo "wanted     : ".$sbJSON_ShowTotal->{data}->{wanted}."<br>";
    echo "downloaded : ".$sbJSON_ShowTotal->{data}->{downloaded}->{total}."<br>";
    echo "snatched   : ".$sbJSON_ShowTotal->{data}->{snatched}->{total}."<br>";
    echo "<hr>";

  }

#============ (1 START) ----------------------------------------------------

    // Show URL
  $apiURL_sbSeasonList = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasonlist&tvdbid=".$showid."&sort=asc";
  $apiURL_sbShow = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show&tvdbid=".$showid;
  $apiURL_TraktTV = "http://api.trakt.tv/show/episode/summary.json/".$trakt_api."/".$showid."/1/1";
  if ($debug == "true") {
        echo "apiURL_sbSeasonList : ".$apiURL_sbSeasonList."<br>";
        echo "apiURL_sbShow       : ".$apiURL_sbShow."<br>";
        echo "apiURL_TraktTV      : ".$apiURL_TraktTV."<br>";
  }
  
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
  if ($display_img_banners == "true") {	
      // Show Trakt.TV banner
      if ($trakt_enabled == "true") {
          if ($trakt->{status} == "failure") {
            // Show SickBeard Banner if trakt returned an error
            printf("<img src=http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.getbanner&tvdbid=".$showid."><br>");
          } else {
            // Show trakt.tv Banner
            printf("<img src=".$trakt->{show}->{images}->{banner}."><br>");
          }
      } else {
          // Show SickBeard Banner
          printf("<img src=http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.getbanner&tvdbid=".$showid."><br>");
      }
  } else {
      echo "<h1>(1) ".$title."</h1>";
  }
  
  if ($trakt_enabled == "true") {
    echo "<b>Year:</b> ".$trakt->{show}->{year}." | ";
    echo "<b>Country:</b> ".$trakt->{show}->{country}." | ";
    echo "<b>Network:</b> ".$trakt->{show}->{network}." | ";
    echo "<b>Run Time:</b> ".$trakt->{show}->{runtime}." Mins | ";
    echo "<b>Runs:</b> ".$trakt->{show}->{air_day}.", ".$trakt->{show}->{air_time}."<br>";
    /* echo "<b>Overview:</b> ".$trakt->{show}->{overview}."<br><br>"; */
  } else {
    // Show Sickbeard Next Episode
    if ($tvdata->{data}->{next_ep_airdate} == "") {
      $next_ep = "N/A";
    } else {
      $next_ep = $tvdata->{data}->{next_ep_airdate};
    }
    // Show Details Next Episode
    echo "Network: ".$tvdata->{data}->{network}." | ";
    echo "Airs: ".$tvdata->{data}->{airs}." | ";
    echo "Next Ep: ".$next_ep." | ";
    echo "Show Status: ".$tvdata->{data}->{status}."<br>";
  }

	// Run through each feed item
	foreach($sbJSON->{data} as $show) {
    $seasonid = $show;
#============ (2.1 START) ------------------------------------------------------

echo "<hr>";

$apiURL_sbSeason = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasons&tvdbid=".$showid."&season=".$seasonid;
echo "apiURL_sbSeason : ".$apiURL_sbSeason."<br>";

$sbJSON_sbSeason = json_decode(file_get_contents($apiURL_sbSeason));

    // Define episode counter
    $counter = "1";

    $countArchived = "0";
    
    // Run through each feed item
    foreach($sbJSON_sbSeason->{data} as $sbEpisode) {
      // Show Details

echo "        <a href='epdata.php?showid=".$showid."&seasonid=".$seasonid."&ep=".$counter."'>" . $counter . "</a>";
echo '      </td>';
echo '      <td id="name_episode">';
            echo $sbEpisode->{name};
echo '      </td>';
echo '      <td id="airdate">';
            echo $sbEpisode->{airdate};
echo '      </td>';
echo '      <td id="status">';
            if ($sbEpisode->{status} == "Archived")
            {
              echo "<font color='#41A317'>Collected </font>";
              $countArchived = $countArchived + "1";
            } 
            elseif ($sbEpisode->{status} == "Snatched")
            {
              echo "<font color='#41A317'>Downloading... </font>";
            }
            elseif ($sbEpisode->{status} == "Downloaded")
            {
              echo "<font color='#41A317'>Collected </font>";
            }
            elseif ($sbEpisode->{status} == "Wanted")
            {
              echo "<font color='#306EFF'>Wanted </font>";
            } 
            else
            {
              echo "<font color='#F62817'>Not Collected </font>";
            }
            $counter = $counter + "1";
echo '      </td>';
echo '    </tr>';
        }

echo "<hr>";

#============ (2.1 END) --------------------------------------------------------

#============ (2.2 START) ------------------------------------------------------
    
    
    // Check if username is available, set URL
    $feed3_1 = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasons&tvdbid=".$showid."&season=".$seasonid;
    $feed3_2 = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show&tvdbid=".$showid;
    $feed3_3 = "http://api.trakt.tv/show/episode/summary.json/".$trakt_api."/".$showid."/1/1";
    if ($debug == "true") {
        echo "feed3_1 : ".$feed3_1."<br>";
        echo "feed3_2 : ".$feed3_2."<br>";
        echo "feed3_3 : ".$feed3_3."<br>";
    }
  
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
    
echo '<table class="display" id="episodes_table">';
echo '  <thead>';
echo '    <tr>';
echo '      <th id="name_show">';

    if ($seasonid == '0') {
      echo ''.$title.' - Specials';
    } else {
      echo ''.$title.' - Season '.$seasonid;
    }

echo '      </th>';
echo '      <th id="episode">Episode</th>';
echo '      <th id="name_episode">Name</th>';
echo '      <th id="airdate">Aired</th>';
echo '      <th id="status">Status</th>';
echo '    </tr>';
echo '  </thead>';

    // Define episode counter
    $counter = "1";
    
    // Run through each feed item
    foreach($sbJSON->{data} as $show) {
      // Show Details

echo '  <tbody>';      
echo '    <tr class="gradeZ">';
echo '      <td>&nbsp;</td>';
echo '      <td id="episode">';
echo "        <a href='epdata.php?showid=".$showid."&seasonid=".$seasonid."&ep=".$counter."'>" . $counter . "</a>";
echo '      </td>';
echo '      <td id="name_episode">';
            echo $show->{name};
echo '      </td>';
echo '      <td id="airdate">';
            echo $show->{airdate};
echo '      </td>';
echo '      <td id="status">';
            if ($show->{status} == "Archived")
            {
              echo "<font color='#41A317'>Collected </font>";
            } 
            elseif ($show->{status} == "Snatched")
            {
              echo "<font color='#41A317'>Downloading... </font>";
            }
            elseif ($show->{status} == "Downloaded")
            {
              echo "<font color='#41A317'>Collected </font>";
            }
            elseif ($show->{status} == "Wanted")
            {
              echo "<font color='#306EFF'>Wanted </font>";
            } 
            else
            {
              echo "<font color='#F62817'>Not Collected </font>";
            }
            $counter = $counter + "1";
echo '      </td>';
echo '    </tr>';
        }
echo '  <tbody>';
echo '</table>';
#============ (2.2 END) ------------------------------------------------------
    }

#============ (1 END) ---------------------------------------------------
}


?>
    </div>
</body>
</html>
