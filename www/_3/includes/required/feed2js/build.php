<?php
$src = (isset($_GET['src'])) ? $_GET['src'] : '';
$chan = (isset($_GET['chan'])) ? $_GET['chan'] : 'n';
$num = (isset($_GET['num'])) ? $_GET['num'] : 0;
$desc = (isset($_GET['desc'])) ? $_GET['desc'] : 0;
$auth = (isset($_GET['au'])) ? $_GET['au'] : 'n';
$date = (isset($_GET['date'])) ? $_GET['date'] : 'n';
$tz = (isset($_GET['tz'])) ? $_GET['tz'] : 'feed';
$targ = (isset($_GET['targ'])) ? $_GET['targ'] : 'myiframe';
$html = (isset($_GET['html'])) ? $_GET['html'] : 'n';
$utf = (isset($_GET['utf'])) ? $_GET['utf'] : 'y';
$rss_box_id = (isset($_GET['rss_box_id'])) ? $_GET['rss_box_id'] : '';
$pc = (isset($_GET['pc'])) ? $_GET['pc'] : 'n';

if (strpos($src, '<script>')) {
	$src = preg_replace("/(\<script)(.*?)(script>)/si", "SCRIPT DELETED", "$src");
	die("Warning! Attempt to inject javascript detected. Aborted and tracking log updated.");
}

	$generate = (isset($_GET['generate'])) ? $_GET['generate'] : '';
	if (isset($generate)) $generate = $_GET['generate'];
	if ($html=='a') $desc = 0;

	$options = '';	
	if ($chan != 'n') $options .= "&chan=$chan";
	if ($num != 0) $options .= "&num=$num";
	if ($desc != 0) $options .= "&desc=$desc";
	if ($auth != 'n') $options .= "&au=$auth";
	if ($date != 'n') $options .= "&date=$date";
	if ($tz != 'feed') $options .= "&tz=$tz";
	if ($targ != 'n') $options .= "&targ=$targ";
	if ($html != 'n') $html_options = "&html=$html";
	if ($utf == 'y') {
		$options .= '&utf=y';
		$utf_str = ' charset="UTF-8"';
	} else {
	    $utf_str = '';
	}
	if ($rss_box_id != '') $options .= "&css=$rss_box_id";
	if ($pc == 'y') $options .= '&pc=y';
	
if ($generate) {
		$rss_str = urlencode($src);
}
?>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="style/main.css" media="all" />
<link rel="stylesheet" href="../../css/portal.css" media="all" />
<script type="text/javascript" language="Javascript">
<!--
function query_str(form) {
	options = encodeURIComponent(form.src.value);

	if (form.chan[2].checked) {
		options += '&chan=n';
	} else if (form.chan[1].checked) {
		options += '&chan=title';
	}
	
	if (form.num.value != 0) options += '&num=' + form.num.value;
	if (form.desc.value != 1 && !form.html[0].checked) options += '&desc=' + form.desc.value;

	if (form.date[0].checked) options += '&date=y';
	if (form.tz.value != 'feed') options += '&tz=' + form.tz.value;
	
	if (form.html[0].checked) {
		options += '&html=a';
	} else if (form.html[2].checked) {
		options += '&html=p';
	}

	options += '&targ=' + form.targ.value;
	
	if (form.utf.checked) options += '&utf=y';
	options += '&css=' + form.rss_box_id.value;
	
	if (form.pc[0].checked) options += '&pc=y';
	
	if (form.au[0].checked) options += '&au=y';
	
	return(options);
}
//-->
</script>
<script src="popup.js" type="text/javascript" language="Javascript"></script>
<script type="text/javascript">
function goBack() {
	window.history.go(-1)
}
</script>

</head>
<body>
<div id="content">
	<div id="nav"><center><input class="classpanel" type="button" value="Go Back" onclick="goBack()" /></center></div>
	<h1>Feed2JS Build</h1>
	<p class="first">The original version of this tool can be found <a href="http://feed2js.org/" target="_new">here</a> and is Open Source. In the spirit of Open Source, the local copy provided with this project has been modified/stripped down to help remove confusion for the end users.</p>
	<hr />

	<?php if ($generate):?>
		<p class="first">Below is the URL converted to ASCII that you will need to copy/paste for your RSS Feeds.<br />
		</p>
		<form>
			<span class="caption">cut and paste modified url:</span><br>
			<textarea name="t" rows="8" cols="70"><?php echo htmlentities($rss_str)?></textarea>
		</form>
	<?php endif?>

	<form method="get" action="build.php"  name="builder">
		<p><strong>URL</strong><br />Enter the web address of the RSS Feed (must be in http:// format, not feed://)<br>
		<input type="text" name="src" size="50" value="<?php echo $src?>"><br />
			<span style="font-size:x-small">Note: Please verify the URL of your feed and <a href="http://feedvalidator.org/" onClick="window.open('http://feedvalidator.org/check.cgi?url=' + encodeURIComponent(document.builder.src.value), 'check'); return false;">check that it is valid</a> before using this form.</span>
		</p>

		<div id="badge" style="width:250px; padding:0;">
			<h3 class="badge-header">Show n' Tell!</h3>
			<div align="center"><input type="submit" name="generate" value="Generate JavaScript" /></div>
		</div>
	</form>
</div>
<?php include 'footer'?>
</body>
</html>