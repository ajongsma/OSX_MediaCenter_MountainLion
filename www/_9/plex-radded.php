<?php

// Settings
include 'config.php';
include 'header.php';
include 'plex-header.php';

$url = "http://".$plex_ip."/library/recentlyAdded";
$achxml = simplexml_load_file($url);

echo "<title> Plex Recently Added | ".$site_name."</title>";
echo "<h1>Plex Recently Added</h1>";

echo "<b>Shows</b><br>";
foreach($achxml->Directory AS $child) {
    echo "<a href='plex-shows-eps.php?epid=".$child['ratingKey']."'>".$child['parentTitle'].", ".$child['title'].", Eps: ".$child['leafCount']."</a><br>";
}

echo "<br><b>Movies</b><br>";
foreach($achxml->Video AS $child) {
    echo "<a href='plex-movies-data.php?movieid=".$child['ratingKey']."'>".$child['title']."</a><br>";
}

include 'footer.php';

?>