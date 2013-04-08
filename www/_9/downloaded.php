<?php

// Settings
include 'config.php';
echo "<title>Recently Snatched | ".$site_name."</title>";

// Check if username is available, set URL
// This probably isn't necessary
    $feed = "http://".$ip."/api/".$api."?cmd=history&type=snatched&limit=25";
    
$sbJSON = json_decode(file_get_contents($feed));

// What are you!?
echo "<center>";
include 'header.php';
echo "<h1>Recently Snatched</h1>";

// Run through each feed item
foreach($sbJSON->{data} as $show) {

        // Reformat date
        $newDate = date("l, j F Y g:ia", strtotime($show->{date}));

        // Show Details
        echo "<a href='epdata.php?showid=".$show->{tvdbid}."&seasonid=".$show->{season}."&ep=".$show->{episode}."'>" . $show->{show_name} . ", S" . $show->{season} . " E" . $show->{episode} . "</a> | " .$newDate . "<br />";
}
include 'footer.php';
echo "</center>";
?>