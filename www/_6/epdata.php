<?php

include 'config.php';
include 'header.php';

// Get the show id from last page
$showid = $_GET['showid'];
$seasonid = $_GET['seasonid'];
$epid = $_GET['ep'];

// Define feeds
$feed = "http://".$ip."/api/".$api."/?cmd=episode&tvdbid=".$showid."&season=".$seasonid."&episode=".$epid;
$feed2 = "http://".$ip."/api/".$api."/?cmd=show&tvdbid=".$showid;
$feed3 = "http://api.trakt.tv/show/episode/summary.json/".$trakt_api."/".$showid."/".$seasonid."/".$epid;

// fetch trakt api
if ($trakt_enabled == "1")
{
	$sbJSON = json_decode(file_get_contents($feed));
	$tvdata = json_decode(file_get_contents($feed2));
	$trakt = json_decode(file_get_contents($feed3));
}
else
{
	$sbJSON = json_decode(file_get_contents($feed));
	$tvdata = json_decode(file_get_contents($feed2));
}

// Grab Show Title
$title = $tvdata->{data}->{show_name};

//Display Browser Title
echo "<title>".$title." | Season ".$seasonid." | Episode ".$epid." | ".$site_name."</title>";
echo "<center>";

// What are you!?
echo "<h1>".$title." Season ".$seasonid." Episode ".$epid."</h1>";
echo "<a href='episode.php?showid=".$showid."&seasonid=".$seasonid."'>Back</a><br>";

// trakt.tv banner intragration
if ($trakt_enabled == "1")
{
	printf("<img src=".$trakt->{show}->{images}->{banner}."><br><br>");
}
else
{
	// Display Show Bannger
	printf("<img src=http://".$ip."/api/".$api."/?cmd=show.getbanner&tvdbid=".$showid."><br><br>");
}

        // Show Details
        echo "<b>Episode:</b> " . $epid . "</a><br />";
        echo "<b>Name:</b> " . $sbJSON->{data}->{name} . "<br />";
        if ($trakt_enabled == "1")
        {
        	echo "<b>Screen Grab:</b> <br>";
        	printf("<img src=".$trakt->{episode}->{images}->{screen}."><br><br>");
        }
        else
        {
        	echo "";
        }
        echo "<b>Description:</b> " . $sbJSON->{data}->{description} . "<br><br>";
        echo "<b>Aired:</b> " . $sbJSON->{data}->{airdate} . "<br />";
        echo "<b>Quality:</b> " . $sbJSON->{data}->{quality} . "<br />";
        if ($sbJSON->{data}->{status} == "Archived")
        {
        	echo "<font color='#41A317'><b>Status:</b> Collected </font><br /><br />";
        }
        elseif ($sbJSON->{data}->{status} == "Snatched")
        {
        	echo "<font color='#41A317'><b>Status:</b> Downloading... </font><br /><br />";
        }
        elseif ($sbJSON->{data}->{status} == "Downloaded")
        {
        	echo "<font color='#41A317'><b>Status:</b> Collected </font><br /><br />";
        }
        elseif ($sbJSON->{data}->{status} == "Wanted")
        {
        	echo "<font color='#306EFF'><b>Status:</b> Wanted </font><br /><br />";
        }
        else
        {
        	echo "<font color='#F62817'><b>Status:</b> Not Collected </font><br /><br />";
        }
include 'footer.php';        
echo "</center>";
?>