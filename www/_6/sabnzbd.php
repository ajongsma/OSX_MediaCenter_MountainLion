<?php

// Settings
include 'config.php';
include 'header.php';
echo "<title>Download Queue | ".$site_name."</title>";
echo "<center>";
// Feed URL
$feed = "http://".$sab_ip."/api?mode=qstatus&output=json&apikey=".$sab_api;
    
$sbJSON = json_decode(file_get_contents($feed));

if($sab_enabled == "1")
{

// What are you!?
echo "<h1>Download Queue</h1>";

if ($sbJSON->{mb} > "0")
{
echo "Timeleft: ".$sbJSON->{timeleft}."<br />";
if ($sbJSON->{paused} == "")
{
}
else
{
	echo "Downloads Paused: ".$sbJSON->{paused}."<br />";
}
echo "<b>Queued:</b> ".$sbJSON->{mb}." MB<br />";
echo "<b>Speed:</b> ".$sbJSON->{kbpersec}." Kbps<br /><br>";
echo "<b>Jobs:</b><br>";

foreach($sbJSON->{jobs} as $job) {

        // Show Details
        echo "<b>Filename:</b> ".$job->{filename}."<br>";
        echo "<b>Size:</b> ".$job->{mb}."<br>";
        echo "<b>Size Left:</b> ".$job->{mbleft}."<br><br>";
        
}
}
else
{
	echo "<b>Queue is Empty!</b>";
}
}
else
{
	echo "<br><b>Module is disabled!</b>";
}
include 'footer.php';
echo "</center>";
?>