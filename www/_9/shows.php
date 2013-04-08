<center>
<?php

include 'config.php';
echo "<title>TV Shows | ".$site_name."</title>";

include 'header.php';

$feed = "http://".$ip."/api/".$api."/?cmd=shows&sort=name&paused=0";
$feed2 = "http://".$ip."/api/".$api."/?cmd=shows.stats";
        
$sbJSON = json_decode(file_get_contents($feed),true);
$stats = json_decode(file_get_contents($feed2));
	
echo "<h1>Shows</h1>";

foreach ($sbJSON['data'] as $key => $values)
	{
    	echo '<a href="seasonlist.php?showid=' . $values['tvdbid'] . '">' . $key . '</a><br />';
	}

echo "<br>Eps Downloaded: ".$stats->{data}->{ep_downloaded}." of ".$stats->{data}->{ep_total}." == Shows Active: ".$stats->{data}->{shows_active}." of ".$stats->{data}->{shows_total};
include 'footer.php';
?>
</center>
