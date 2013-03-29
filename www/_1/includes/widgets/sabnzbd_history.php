<?php
/* ---- HISTORY ---- */
$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=history&start=0&limit=5&output=json&apikey=$sabnapi";
$json = file_get_contents($url);
$data = json_decode($json, TRUE);
$contents = file_get_contents($url);
$contents = json_decode($contents, true);

/* download status ('Completed', 'Paused', 'Queued, 'Failed', 'Verifying', 'Downloading', 'Extracting') */
$sab_slots = $contents['history']['slots'];

echo "<div class='downloadPage downloadPageHistory'>";
echo "<h2>Recently Finished</h2>";
echo "<ul>";

foreach($sab_slots as $slot) {
		echo "<li>".$slot['category']." - ".$slot['nzb_name']."</li>";
}
echo "</ul>";
echo "</div>";
?>