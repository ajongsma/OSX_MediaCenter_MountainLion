<?php

// Settings
include 'config.php';
include 'header.php';
include 'plex-header.php';

$movieid = $_GET['movieid'];

$url = "http://".$plex_ip."/library/metadata/".$movieid;
$achxml = simplexml_load_file($url);
echo "<title>".$achxml->Video['title']." | ".$site_name."</title>";
foreach($achxml->Video AS $child) {
	echo "<h1>".$child['title']."</h1>";
    echo "<b>Year:</b> ".$child['year']."<br>";
	$added_changed = date('g:ia d/m/y', (int) $child['addedAt']);
	$updated_changed = date('g:ia d/m/y', (int) $child['updatedAt']);
	echo "<b>Added:</b> ".$added_changed." | <b>Updated:</b> ".$updated_changed." | <b>Total Views:</b> ".$child['viewCount']."<br>";
    echo "<b>Summary:</b> ".$child['summary']."<br>";
    echo "<b>Studio:</b> ".$child['studio']."<br>";
   	echo "<b>Bitrate:</b> ".$child->Media['bitrate']." | <b>Width:</b> ".$child->Media['width']." | <b>Height:</b> ".$child->Media['height']." | <b>AudioChannels:</b> ".$child->Media['audioChannels']." | <b>AudioCodec:</b> ".$child->Media['audioCodec']." | <b>VideoCodec:</b> ".$child->Media['videoCodec']." | <b>VideoResolution:</b> ".$child->Media['videoResolution']." | <b>VideoFrameRate:</b> ".$child->Media['videoFrameRate']."<br>";
    echo "<b>File Location:</b> ".$child->Media->Part['file']."<br><br>";
   	printf("<img src=http://".$plex_ip.$child['thumb']."><br><br>");

}

echo "<b>Genre</b><br>";
foreach($achxml->Video->Genre AS $Genre) {
	echo $Genre['tag'].", "; }

echo "<br><b>Actors</b><br>";
foreach($achxml->Video->Role AS $role) {
	echo $role['tag'].", "; }

include 'footer.php';

?>