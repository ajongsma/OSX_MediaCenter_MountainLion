<?php

// Settings
include 'config.php';
include 'header.php';
include 'plex-header.php';

$epid = $_GET['epid'];

$url = "http://".$plex_ip."/library/metadata/".$epid."/children";
$achxml = simplexml_load_file($url);
echo "<title>".$achxml['title1']." | ".$achxml['title2']." | ".$site_name."</title>";
echo "<h1>".$achxml['title1']." | ".$achxml['title2']."</h1>";
foreach($achxml AS $child) {
	//echo "<h1>".$child['title']."</h1>";
	echo "<b>Episode:</b> ".$child['index']."<br>";
	echo "<b>Name:</b> ".$child['title']."<br>";
	echo "<b>Aired:</b> ".$child['originallyAvailableAt']."<br>";
	$added_changed = date('g:ia d/m/y', (int) $child['addedAt']);
	$updated_changed = date('g:ia d/m/y', (int) $child['updatedAt']);
	echo "<b>Added:</b> ".$added_changed." | <b>Updated:</b> ".$updated_changed." | <b>Total Views:</b> ".$child['viewCount']."<br>";
	echo "<b>Summary:</b> ".$child['summary']."<br>";
	echo "<b>File:</b> ".$child->Media->Part['file']."<br>";
	echo "<b>Bitrate:</b> ".$child->Media['bitrate']." | <b>Width:</b> ".$child->Media['width']." | <b>Height:</b> ".$child->Media['height']." | <b>AudioChannels:</b> ".$child->Media['audioChannels']." | <b>AudioCodec:</b> ".$child->Media['audioCodec']." | <b>VideoCodec:</b> ".$child->Media['videoCodec']." | <b>VideoResolution:</b> ".$child->Media['videoResolution']." | <b>VideoFrameRate:</b> ".$child->Media['videoFrameRate']."<br><br>";
	printf("<img src=http://".$plex_ip.$child['thumb'].">");
	echo "<br><br>";
}

include 'footer.php';

?>