<?php

include 'config.php';
include 'header.php';

$albumid = $_GET['id'];

$feed = "http://".$headphones_ip."/api?apikey=".$headphones_api."&cmd=getAlbum&id=".$albumid;
        
$sbJSON = json_decode(file_get_contents($feed));
	
foreach($sbJSON->{album} as $headphones) {
		echo "<title>".$headphones->{AlbumTitle}." | ".$headphones->{ArtistName}." | ".$site_name."</title>";
		echo "<h1>".$headphones->{AlbumTitle}." | ".$headphones->{ArtistName}."</h1>";
		printf("<img src=".$headphones->{ArtworkURL}."><br><br>");
		echo "<b>Album Title:</b> ".$headphones->{AlbumTitle}."<br>";
		echo "<b>Artist:</b> ".$headphones->{ArtistName}."<br>";
		echo "<b>Release Date:</b> ".$headphones->{ReleaseDate}."<br>";
		echo "<b>Status:</b> ".$headphones->{Status}."<br><br>";
	}

foreach($sbJSON->{tracks} as $headphones) {
		echo "<b>Track:</b> ".$headphones->{TrackNumber}."<br>";
    	echo "<b>Title:</b> ".$headphones->{TrackTitle}."<br>";
    	echo "<b>Format:</b> ".$headphones->{Format}."<br>";
    	echo "<b>Location:</b><br> ".$headphones->{Location}."<br><br>";

	}

include 'footer.php';

?>