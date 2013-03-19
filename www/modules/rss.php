<?php
// Variable Conversion
$feed0name	=	$ini['feed0name'];
$feed0		=	$ini['feed0'];
$feed1name	=	$ini['feed1name'];
$feed1		=	$ini['feed1'];
$feed2name	=	$ini['feed2name'];
$feed2		=	$ini['feed2'];
$feed3name	=	$ini['feed3name'];
$feed3		=	$ini['feed3'];
$feed4name	=	$ini['feed4name'];
$feed4		=	$ini['feed4'];
$feed5name	=	$ini['feed5name'];
$feed5		=	$ini['feed5'];
$feed6name	=	$ini['feed6name'];
$feed6		=	$ini['feed6'];
$feed7name	=	$ini['feed7name'];
$feed7		=	$ini['feed7'];
$feed8name	=	$ini['feed8name'];
$feed8		=	$ini['feed8'];
$feed9name	=	$ini['feed9name'];
$feed9		=	$ini['feed9'];
if (!isset($ini['rsscount'])) { $ini['rsscount']            = 20; }
$rsscount = $ini['rsscount'];

// 
$RSSToggle = '<a href="#" onClick="ddaccordion.collapseall(\'technology\'); return false">Collapse all</a>  | <a href="#" onClick="ddaccordion.expandall(\'technology\'); return false">Expand all</a>';

function writeRSSName($RSSName) {
	echo '<div class="technology">' . $RSSName . '</div>';
}
function writeRSS($feed,$rsscount) {
	echo '<div class="thelanguage"><script language="JavaScript" src="includes/required/feed2js/feed2js.php?src=' . $feed . '&amp;num=' . $rsscount . '" type="text/javascript"></script></div>';
}
?>
<div id="rss" class="rss">
	<?php 
		echo $RSSToggle;
		if ($feed0name!="" && $feed0!="") {
			writeRSSName($feed0name);
			writeRSS($feed0,$rsscount);
		}
		if ($feed1name!="" && $feed1!="") {
			writeRSSName($feed1name);
			writeRSS($feed1,$rsscount);
		}
		if ($feed2name!="" && $feed2!="") {
			writeRSSName($feed2name);
			writeRSS($feed2,$rsscount);
		}
		if ($feed3name!="" && $feed3!="") {
			writeRSSName($feed3name);
			writeRSS($feed3,$rsscount);
		}
		if ($feed4name!="" && $feed4!="") {
			writeRSSName($feed4name);
			writeRSS($feed4,$rsscount);
		}
		if ($feed5name!="" && $feed5!="") {
			writeRSSName($feed5name);
			writeRSS($feed5,$rsscount);
		}
		if ($feed6name!="" && $feed6!="") {
			writeRSSName($feed6name);
			writeRSS($feed6,$rsscount);
		}
		if ($feed7name!="" && $feed7!="") {
			writeRSSName($feed7name);
			writeRSS($feed7,$rsscount);
		}
		if ($feed8name!="" && $feed8!="") {
			writeRSSName($feed8name);
			writeRSS($feed8,$rsscount);
		}
		if ($feed9name!="" && $feed9!="") {
			writeRSSName($feed9name);
			writeRSS($feed9,$rsscount);
		}
		?>
</div>