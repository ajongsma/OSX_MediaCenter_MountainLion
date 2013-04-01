<?php

include 'config.php';
echo "<title>Headphones | ".$site_name."</title>";

include 'header.php';

$feed = "http://".$headphones_ip."/api?apikey=".$headphones_api."&cmd=getIndex";
        
$sbJSON = json_decode(file_get_contents($feed));
	
echo "<h1>Headphones</h1>";

foreach($sbJSON as $headphones) {
    	echo "<a href='headphones-artist.php?id=".$headphones->{ArtistID}."'>".$headphones->{ArtistName}."</a><br>";
	}

include 'footer.php';

?>