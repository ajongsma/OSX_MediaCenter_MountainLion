<?php

// Settings
include 'config.php';
include 'header.php';
include 'plex-header.php';

echo "<title>PlexShows | ".$site_name."</title>";

$url = "http://".$plex_ip."/library/sections/1/all";
$achxml = simplexml_load_file($url);
echo "<h1>PlexShows</h1>";
foreach($achxml->Directory AS $child) {
    echo "<a href='plex-shows-season.php?key=".$child['ratingKey']."'>".$child['title']."</a><br>";
}

include 'footer.php';

?>