<?php
require '../required/defaults.php';
require '../required/header.php';

$ini_ini_filename = '../../settings.ini';
if (@is_readable($ini_ini_filename)) {
	$ini = parse_ini_file($ini_ini_filename, FALSE);
}
else {
	unset($ini);
}
?>
<link rel="stylesheet" type="text/css" href="../css/portal.css" />

<div id="configPageHeader"><strong>Welcome to the HTPCPortal Configuration page.</strong><br />
This page does NOT currently create or alter your configuration and simply displays the information for you. This will hopefully change shortly after I'm happy with the overall layout and design.<br /><br />
</div>

<div id="nav">
<?php
$file = "..\..\settings.ini";
$filename = "settings.ini";
if (!(file_exists($file))) {
	echo ("<strong>$filename</strong> The file doesn't exist.");
	} else {
	echo ("<strong>$filename</strong> File exists");
}
?>
</div>	
<table class="configTable" border="0">
	<tr>
    	<td colspan="7" align="center" id="nav"><strong>Media Servers</strong></td>
        <td colspan="4" align="center" id="nav"><strong>NZB Sites</strong></td>
    </tr>
	<tr>
    	<td width="75" height="65" rowspan="4" align="center"><img src="../images/apps/XBMC.png" title="XBMC" /></td>
        <td width="75">Hostname:</td>
        <td width="20%"><?php echo $ini['xbmc'] ?></td>
        <td rowspan="4"></td>
    	<td width="75" height="65" rowspan="4" align="center"><img src="../images/apps/Plex.png" title="Plex" /></td>
        <td width="75">Hostname:</td>
        <td width="20%"><?php echo $ini['plex'] ?></td>
        <td rowspan="4"></td>
    	<td width="75">Matrix User</td>
        <td colspan="2"><?php echo $ini['matrixuser'] ?></td>
    </tr>
	<tr>
        <td>Port:</td>
        <td><?php echo $ini['xport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['plexport'] ?></td>
        <td>Matrix API</td>
        <td colspan="2"><?php echo $ini['matrixapi'] ?></td>
    </tr>
    <tr>
		<td>User:</td>
        <td><?php echo $ini['xbmcuser'] ?></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>NZB.su</td>
        <td colspan="2"><?php echo $ini['nzbsuapi'] ?></td>
    </tr>
    <tr>
        <td>Pass:</td>
        <td><?php echo $ini['xbmcpass'] ?></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
	<tr>
    	<td colspan="11" align="center" id="nav"><strong>Management</strong></td>
    </tr>
	<tr>
    	<td rowspan="4" align="center"><img src="../images/apps/Maraschino.png" title="Maraschino" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['mara'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/SickBeard.png" title="SickBeard" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['sick'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/CouchPotato.png" title="CouchPotato" /></td>
        <td width="75">Hostname:</td>
        <td width="20%"><?php echo $ini['couch'] ?></td>
    </tr>
	<tr>
        <td>Port:</td>
        <td><?php echo $ini['maraport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['sbport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['cpport'] ?></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>API Key:</td>
        <td><?php echo $ini['sbapi'] ?></td>
        <td>API Key:</td>
        <td>Not Implemented</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
	<tr>
    	<td colspan="11" align="center" id="nav"><strong>Downloaders</strong></td>
    </tr>
	<tr>
    	<td rowspan="4" align="center"><img src="../images/apps/SabNZBd.png" title="SabNZBd+" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['sab'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/uTorrent.png" title="&micro;Torrent" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['utor'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/jDownloader.png" title="jDownloader" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['jDown'] ?></td>
    </tr>
	<tr>
        <td>Port:</td>
        <td><?php echo $ini['sabport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['utport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['jDport'] ?></td>
    </tr>
    <tr>
        <td>API Key:</td>
        <td><?php echo $ini['sabapi'] ?></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
	<tr>
    	<td colspan="11" align="center" id="nav"><strong>Other</strong></td>
    </tr>
	<tr>
    	<td rowspan="4" align="center"><img src="../images/apps/Headphones.png" title="Headphones" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['headphones'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/AutoMovies.png" title="AutoMovies" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['autom'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/SubSonic.png" title="SubSonic" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['subs'] ?></td>
    </tr>
	<tr>
        <td>Port:</td>
        <td><?php echo $ini['headport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['amport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['ssport'] ?></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
	<tr>
    	<td rowspan="4" align="center"><img src="../images/apps/Transmission.png" title="Transmission" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['transmission'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/TVHeadend.png" title="TVHeadend" /></td>
        <td>Hostname:</td>
        <td><?php echo $ini['tvhe'] ?></td>
		<td rowspan="4"></td>
    	<td rowspan="4" align="center"><img src="../images/apps/XBMC.png" /></td>
        <td>Hostname:</td>
        <td>&nbsp;</td>
    </tr>
	<tr>
        <td>Port:</td>
        <td><?php echo $ini['tranport'] ?></td>
        <td>Port:</td>
        <td><?php echo $ini['tvhport'] ?></td>
        <td>Port:</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
	<tr>
    	<td colspan="11" align="center" id="nav"><strong>RSS Info</strong></td>
	</tr>
	<tr>
		<td colspan="3" align="center"><a class="classpanel" href="../required/feed2js/build.php">RSS Editor</a></td>
		<td colspan="8">To create valid RSS Feeds for this site, you must click the link to the left and follow the directions.</td>
	</tr>
</table>
</body>
</html>