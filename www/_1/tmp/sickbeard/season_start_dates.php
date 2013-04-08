<?php

require_once('functions.php');

$version = 0.1;

/* Verify 'settings.ini' is available, if not, attempt to use defaults below; */
$ini_ini_filename = '../../settings.ini';
if (@is_readable($ini_ini_filename)) {
	$ini = parse_ini_file($ini_ini_filename, FALSE);
}
else {
	unset($ini);
}

// SickBeard
if (!isset($ini['sickbeard_host'])) { $ini['sickbeard_host']    = 'localhost'; }
if (!isset($ini['sickbeard_port'])) { $ini['sickbeard_port']    = 8081; }
if (!isset($ini['sickbeard_api'])) { $ini['sickbeard_api']      = 'empty'; }				// API Key
$sickbeard_host													= $ini['sickbeard_host'];
$sickbeard_port													= $ini['sickbeard_port'];
$sickbeard_api													= $ini['sickbeard_api'];

## http://pooky.local:8081/api/404d0302b924328464f83a593a7d155c/?cmd=show.seasons&tvdbid=74608

$apiURL	= 'http://'.$sickbeard_host.':'.$sickbeard_port.'/api/'.$sickbeard_api;
echo $apiURL."<br>";

if (file_exists($apiURL.'/?cmd=sb.ping')) {
	$ping = 'The file' . $filename . ' exists';
} else {
	$ping = 'The file' . $filename . ' does not exist';
}
echo $ping."<br>";

$getShowsFromAPI = json_decode(file_get_contents($apiURL.'/?cmd=shows'));
$i = 0;
foreach($getShowsFromAPI->data as $showid => $show) {
	#$output .= $showid . ' - ' . $show->show_name . '<br/>';
	$output .= '<img class="poster" src="' . data_uri($apiURL . '/?cmd=show.getbanner&tvdbid=' . $showid, 'image/png') . '" alt="' . $showid . ' - ' . $show->show_name . '" />';
	#$output .= '<br/>';

	if ( $i == 20 )
		break;

	$i++;
}
echo $output


/*
echo "<h1>Testing</h1>";
$urlGetShows = "http://$sickbeard_host:$sickbeard_port/api/".$sickbeard_api."/?cmd=shows";
echo "=== URL ===> : ".$urlGetShows."<br>";

$sbJSON = json_decode(file_get_contents($urlGetShows),true);

echo "<table>";
foreach ($sbJSON['data'] as $key => $values){
	echo "  <tr>";
    echo "    <td>". $key . ', ' . $values['show_name'] . "</td>";
    echo "    <td>". $values['status'] . "</td>";
    echo "    <td>". $values['next_ep_airdate'] . "</td>";
    echo "    <td>". ' (TvRage: ' . $values['tvrage_id'] . "</td>";
    echo "    <td>". $values['tvrage_name'] . ')' . "</td>";

	#-------------------------------
echo "  </tr>";
echo "  <tr>";
echo "    <td colspan=5>";
	#-------------------------------
	echo "<table>";

	$urlGetShowDetail = "http://$sickbeard_host:$sickbeard_port/api/".$sickbeard_api."/?cmd=show.seasons&tvdbid=".$key;
	$urlGetShowStats = "http://$sickbeard_host:$sickbeard_port/api/".$sickbeard_api."/?cmd=show.stats&tvdbid=".$key;
	echo "=== URL ===> : ".$urlGetShowDetail."<br>";
	echo "=== URL ===> : ".$urlGetShowStats."<br>";

	$sbJSON_show = json_decode(file_get_contents($urlGetShowStats),true);
	foreach ($sbJSON_show['data'] as $key => $values){
		echo "  <tr>";
		echo "    <td>". $key . ', ' . $values['name'] . "</td>";

		echo "  </tr>";
	}
	echo "</table>";
		#-------------------------------
	echo "    </td>";
	#-------------------------------
    echo "  </tr>";
}
echo "</table>";

// What are you!?
echo "<h1>Season Start Dates</h1>";

$url = "http://$sickbeard_host:$sickbeard_port/api/".$sickbeard_api."/?cmd=future&sort=date&type=later";
echo "=== URL ===> : ".$url."<br>";

$sbJSON = json_decode(file_get_contents($url));
// Run through each feed item
foreach($sbJSON->{data}->{later} as $show) {
    // Only grab shows of episode 1
    if($show->{episode} == "1") {
 
        // Reformat date
        $newDate = date("l, j F Y", strtotime($show->{airdate}));
 
        // Show Details
        echo $show->{show_name} . " Season " . $show->{season} . ": " .$newDate . "<br />";
    }
}
*/

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

	<title>Sick-Beard v<?php echo $version ?></title>
	<link rel="shortcut icon" href="../../img/favicon.ico" />
</head>
<body>
<?php


?>
</body>
</html>
