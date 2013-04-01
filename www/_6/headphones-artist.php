<?php

include 'config.php';
include 'header.php';

$artistid = $_GET['id'];

$feed = "http://".$headphones_ip."/api?apikey=".$headphones_api."&cmd=getArtist&id=".$artistid;
        
$sbJSON = json_decode(file_get_contents($feed));
	
foreach($sbJSON->{artist} as $headphones) {
		echo "<title>".$headphones->{ArtistName}." | ".$site_name."</title>";
		echo "<h1>".$headphones->{ArtistName}."</h1>";
		printf("<img src=".$headphones->{ArtworkURL}."><br><br>");
}
foreach($sbJSON->{albums} as $headphones) {
    	echo "<a href='headphones-album.php?id=".$headphones->{AlbumID}."'>".$headphones->{AlbumTitle}."</a><br>";
    	echo $headphones->{ReleaseDate}."<br>";
    	echo $headphones->{Status}."<br><br>";

	}

include 'footer.php';

?>