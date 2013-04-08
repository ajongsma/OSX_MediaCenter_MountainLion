<?php

// Settings
include 'config.php';

// Check if username is available, set URL
// This probably isn't necessary
    $feed = "http://".$ip."/api/".$api."/?cmd=future&sort=date&type=later";
    
$sbJSON = json_decode(file_get_contents($feed));

// What are you!?
echo "<h1>Airing Later</h1>";

// Run through each feed item
foreach($sbJSON->{data}->{later} as $show) {
    // Only grab shows of episode 1

        // Reformat date
        $newDate = date("l, j F Y", strtotime($show->{airdate}));

        // Show Details
        echo $show->{show_name} . ", S" . $show->{season} . " E" . $show->{episode} . " | " .$newDate . "<br />";
}

?>