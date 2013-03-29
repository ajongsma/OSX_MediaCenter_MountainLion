<?php
/* ---- DOWNLOAD ---- */
/* download status ('Completed', 'Paused', 'Queued, 'Failed', 'Verifying', 'Downloading', 'Extracting') */

$url = "http://$sabnhost:$sabnport/sabnzbd/api?mode=qstatus&output=json&apikey=$sabnapi";
$json = file_get_contents($url);
$data = json_decode($json, TRUE);
$contents = file_get_contents($url);
$contents = json_decode($contents, true);

$sab_state = $contents['state'];
if (strtolower($sab_state) == "idle") {
	echo "<div class='downloadFrame clearfix'>";
	echo "	<div class='downloadPage downloadPageCurrent'>";
	echo "		<h2>" . $sab_state . "</h2>";
	echo "		<span class='currentdl'>" . $sab_filename . "</span>";
	echo "		<progress value='0' max='100'></progress>";
	echo "	</div>";
	echo "</div>";

} else {
	$sab_Speed = $contents['speed'];
	$sab_filename = $contents['jobs']['0']['filename'];
	
	if($sab_filename) {
		$sab_QueueMBTotal = round($contents['mb']);                            # Get size of queue
		$sab_QueueMBLeft = round($contents['mbleft']);                    # Get how much is left of queue
		$sab_QueueMBDone = round($sab_QueueMBTotal - $sab_QueueMBLeft);                 # Calculate how much has been downloaded
		$sab_QueueProgress = round((($sab_QueueMBDone / $sab_QueueMBTotal) * 100),2);  # Calculate percentage downloaded
	}

	echo "<div class='downloadFrame clearfix'>";
	echo "	<div class='downloadPage downloadPageCurrent'>";
	echo "		<h2>" . $sab_state . "</h2>";
	echo "		<span class='currentdl'>" . $sab_filename . "</span>";
	echo "		<progress value='".$sab_QueueMBDone."' max='".$sab_QueueMBTotal."'></progress>";
	echo "		<span class='stats'>".$sab_QueueMBDone." / ".$sab_QueueMBTotal."mb (".$sab_QueueProgress."%) @ ".$sab_Speed."M</span>";
	echo "	</div>";
	echo "</div>";
}
?>