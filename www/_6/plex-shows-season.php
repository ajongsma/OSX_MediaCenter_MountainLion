<?php

// Settings
include 'config.php';
include 'header.php';
include 'plex-header.php';

$showkey = $_GET['key'];

$url = "http://".$plex_ip."/library/metadata/".$showkey."/children";
$achxml = simplexml_load_file($url);
echo "<title>".$achxml['title2']." | ".$site_name."</title>";
echo "<h1>".$achxml['title2']."</h1>";
foreach($achxml AS $child) {
	if ($child['title'] == "All episodes")
	{ echo "<a href='plex-shows-eps.php?epid=".$showkey."/allLeaves'>".$child['title']."</a><br>";	}
	else
	{ echo "<a href='plex-shows-eps.php?epid=".$child['ratingKey']."'>".$child['title']."</a><br>"; }
}

include 'footer.php';

?>