<?php

// Settings
include 'config.php';

// Feed URL
$feed = "http://".$ip."/api/".$api."/?cmd=future&sort=date&type=soon";
$feed2 = "http://".$ip."/api/".$api."/?cmd=future&sort=date&type=today|missed";
    
$sbJSON = json_decode(file_get_contents($feed));
$sbJSON2 = json_decode(file_get_contents($feed2));

// styling
echo "<link rel='stylesheet' type='text/css' href='style.css' />";
echo "<div id='site_content'>";

// What are you!?
echo "<h1>Airing Soon</h1>";

// Remove Today header if no shows
if ($sbJSON2->{data}->{today} == "")
{ }
else
{
echo "<u>Today</u><br>";
}

// Run through each feed item
foreach($sbJSON2->{data}->{today} as $show2) {

// Reformat date
$newDate2 = date("l, j F Y", strtotime($show2->{airdate}));

// Show Details
echo "<a href='seasonlist.php?showid=".$show2->{tvdbid}."'>" . $show2->{show_name} . "</a>, S" . $show2->{season} . " E" . $show2->{episode} . " | " .$newDate2 . "<br />";
}

echo "<br><u>Later</u><br>";
foreach($sbJSON->{data}->{soon} as $show) {
// Only grab shows of episode 1

// Reformat date
$newDate = date("l, j F Y", strtotime($show->{airdate}));

// Show Details
echo "<a href='seasonlist.php?showid=".$show->{tvdbid}."'>".$show->{show_name} . "</a>, S" . $show->{season} . " E" . $show->{episode} . " | " .$newDate . "<br />";
}

// Remove Today header if no shows
if ($sbJSON->{data}->{missed} == "")
{ }
else
{
echo "<br><u>Missed</u><br>";
}

// Run through each feed item
foreach($sbJSON2->{data}->{missed} as $show3) {

// Reformat date
$newDate3 = date("l, j F Y", strtotime($show3->{airdate}));

// Show Details
echo "<a href='seasonlist.php?showid=".$show2->{tvdbid}."'>" . $show3->{show_name} . "</a>, S" . $show3->{season} . " E" . $show3->{episode} . " | " .$newDate3 . "<br />";
}
echo "</div>";
?>