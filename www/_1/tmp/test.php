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
  <hr>
  http://stackoverflow.com/questions/12767695/merge-multiple-json-into-single-object
  <hr>
  <div id='site_content'>
<?php

if(empty($sickbeard_api)) {
  echo "<hr><h1><font color='#F62817'><b>ERROR: Sick-Beard API value is not provided</b></font></h1><hr>";
}
if(($trakt_enabled == "true") && empty($trakt_api)) {
  echo "<hr><h1><font color='#F62817'><b>ERROR: Trakt is enabled but the API value is not provided</b></font></h1><hr>";
}
#============ (1 START) ---------------------------------------------------

$apiURL_sbStatsTotal = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=shows.stats";
echo "<hr>";
echo "<b>apiURL_sbStatsTotal</b> : ".$apiURL_sbStatsTotal;
echo "<hr>";

$sbJSON_StatsTotal = json_decode(file_get_contents($apiURL_sbStatsTotal));
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -<br>";
var_dump($sbJSON_StatsTotal);
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -<br>";

echo "<br>Eps Downloaded: ".$sbJSON_StatsTotal->{data}->{ep_downloaded}." of ".$sbJSON_StatsTotal->{data}->{ep_total}." == Shows Active: ".$sbJSON_StatsTotal->{data}->{shows_active}." of ".$sbJSON_StatsTotal->{data}->{shows_total}."<br><br>";

#============ (1 END) -----------------------------------------------------

#============ (2 START) ---------------------------------------------------

$apiURL_sbShows = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=shows&sort=name&paused=0";
echo "<hr>";
echo "<b>apiURL_sbShows</b> :".$apiURL_sbShows."<br>";
echo "<hr>";

$sbJSON_Shows = json_decode(file_get_contents($apiURL_sbShows),true);
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -<br>";
var_dump($sbJSON_Shows);
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -<br>";
foreach ($sbJSON_Shows['data'] as $key => $values) {
  $showid = $values['tvdbid'];

#============ (2.1 START) ---------------------------------------------------

  $apiURL_sbShowTotal = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.stats&tvdbid=".$showid;
  echo "<hr>";
  echo "<b>apiURL_sbShowTotal</b> : ".$apiURL_sbShowTotal."<br>";
  echo "<hr>";

  $sbJSON_ShowTotal = json_decode(file_get_contents($apiURL_sbShowTotal));
  echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -<br>";
  var_dump($sbJSON_ShowTotal);
  echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -<br>";

# ?????

  $apiURL_sbSeasonList = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasonlist&tvdbid=".$showid."&sort=asc";
  $apiURL_sbShow = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show&tvdbid=".$showid;
  echo "<hr>";
  echo "<b>apiURL_sbSeasonList</b> : ".$apiURL_sbSeasonList."<br>";
  echo "<b>apiURL_sbShow</b>       : ".$apiURL_sbShow."<br>";
  echo "<hr>";

  $sbJSON = json_decode(file_get_contents($apiURL_sbSeasonList));
  $tvdata = json_decode(file_get_contents($apiURL_sbShow));

  echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ";
  var_dump($sbJSON);
  echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ";
  var_dump($tvdata);
  echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ";
  
  foreach($sbJSON->{data} as $show) {
    $seasonid = $show;

    $apiURL_sbSeason = "http://".$sickbeard_host.":".$sickbeard_port."/api/".$sickbeard_api."/?cmd=show.seasons&tvdbid=".$showid."&season=".$seasonid;
    echo "<hr>";
    echo "<b>apiURL_sbSeason</b> : ".$apiURL_sbSeason."<br>";
    echo "<hr>";
    foreach($sbJSON_sbSeason->{data} as $sbEpisode) {
    
    }
  }
#============ (2.1 END) -----------------------------------------------------
}



#============ (2 END) -----------------------------------------------------
?>
    </div>
</body>
</html>
