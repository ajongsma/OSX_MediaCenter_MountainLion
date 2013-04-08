<?php

include 'config.php';
include 'header.php';

// Get the show id from last page
$showid = $_GET['showid'];
$seasonid = $_GET['seasonid'];

// Check if username is available, set URL
    $feed = "http://".$ip."/api/".$api."/?cmd=show.seasons&tvdbid=".$showid."&season=".$seasonid;
    $feed2 = "http://".$ip."/api/".$api."/?cmd=show&tvdbid=".$showid;
    $feed3 = "http://api.trakt.tv/show/episode/summary.json/".$trakt_api."/".$showid."/1/1";
    
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
echo "<title>".$title." | Season ".$seasonid." | ".$site_name."</title>";
echo "<center>";

// What are you!?
echo "<h1>".$title." Season ".$seasonid."</h1>";
echo "<a href='seasonlist.php?showid=".$showid."'>Back</a><br>";

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

// Define episode counter
$counter = "1";

// Run through each feed item
foreach($sbJSON->{data} as $show) {

        // Show Details
        echo "<a href='epdata.php?showid=".$showid."&seasonid=".$seasonid."&ep=".$counter."'><b>Episode:</b> " . $counter . "</a><br />";
        echo "<b>Name:</b> " . $show->{name} . "<br />";
        echo "<b>Aired:</b> " . $show->{airdate} . "<br />";
        if ($show->{status} == "Archived")
        {
        	echo "<font color='#41A317'><b>Status:</b> Collected </font><br /><br />";
        }
        elseif ($show->{status} == "Snatched")
        {
        	echo "<font color='#41A317'><b>Status:</b> Downloading... </font><br /><br />";
        }
        elseif ($show->{status} == "Downloaded")
        {
        	echo "<font color='#41A317'><b>Status:</b> Collected </font><br /><br />";
        }
        elseif ($show->{status} == "Wanted")
        {
        	echo "<font color='#306EFF'><b>Status:</b> Wanted </font><br /><br />";
        }
        else
        {
        	echo "<font color='#F62817'><b>Status:</b> Not Collected </font><br /><br />";
        }

        $counter = $counter + "1";
    }
include 'footer.php';
echo "</center>";
?>