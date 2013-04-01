<?php

// Settings
include 'config.php';
include 'header.php';
include 'plex-header.php';

echo "<title>PlexMovies | ".$site_name."</title>";

$url = "http://".$plex_ip."/library/sections/2/all";
$achxml = simplexml_load_file($url);
echo "<h1>PlexMovies</h1>";
foreach($achxml->Video AS $child) {
    echo "<a href='plex-movies-data.php?movieid=".$child['ratingKey']."'>".$child['title']."</a><br>";
}

include 'footer.php';

?>