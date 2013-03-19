<?php
/* Required Files: Start */
require '../required/defaults.php';
require '../required/header.php';
require 'rpc/TCPClient.php';
/* Required Files: End */

/* Grab Personalized Settings: Start */
$ini_ini_filename = '../../settings.ini';
if (@is_readable($ini_ini_filename)) {
	$ini = parse_ini_file($ini_ini_filename, FALSE);
}
else {
	unset($ini);
}
/* Grab Personalized Settings: End */

/* Variables: Start */
/* XBMC: All */
$xbmchost													= $ini['xbmc'];
$xbmcport													= $ini['xport'];
$xbmcuser													= $ini['xbmcuser'];
$xbmcpass													= $ini['xbmcpass'];

/* XBMC: HTTP API */
$JSONStart  = '<a class="classpanel" target="jsonresponse" href="http://' . $xbmchost . ":" . $xbmcport . '/xbmcCmds/xbmcHttp?command=ExecBuiltIn&parameter=';

/* XBMC: JSON API */
$params = $xbmchost . ':9090';
// Open Connection for JSON
try {
    $rpc = new XBMC_RPC_TCPClient($params);
} catch (XBMC_RPC_ConnectionException $e) {
    die($e->getMessage());
}
// Currently used JSON Commands

?>
<link rel="stylesheet" type="text/css" href="../css/portal.css" />
<?php if ($ini['developer']=="1")
		echo '<div id="commands" align="center"><a class="classpanel" href="remote.php" target="_self">Reload Panel</a><a class="classpanel" href="example.php" target="_self">JSON Tester</a></div><br />';
?>
<p style="color:white">Well, I know this page looks like crap... for now, I'm just screwing around with a layout... and trying to figure out some things with JSON.</p>

	<div id="commands">Commands (JSON API):</div>
	<div id="commands"><strong>XBMC's Current Time:</strong>
	<?php
		try {
			if ($rpc->isLegacy()) {
				$response = $rpc->System->GetInfoLabels(array('System.Time'));
			} else {
				$response = $rpc->XBMC->GetInfoLabels(array('labels' => array('System.Time')));
			}
		} catch (XBMC_RPC_Exception $e) {
			die($e->getMessage());
		}
		printf('%s', $response['System.Time']);
	?>
	</div>
	<div id="commands">
		<?php ?>
	</div>
	<br /><br />
	<div id="commands">Commands (HTTP API):</div>
	<div id="commands"><strong>XBMC </strong>
		<?php echo $JSONStart ?>XBMC.TakeScreenshot">Screenshot</a>
		<?php echo $JSONStart ?>XBMC.Action(ShowSubtitles)">Subtitles</a>
	</div>
	<div id="commands"><strong>Control </strong>
		<?php echo $JSONStart ?>XBMC.PlayerControl(Play)">Pause</a>
		<?php echo $JSONStart ?>XBMC.Reboot">Reboot</a> 
	</div>
	<div id="commands"><strong>Volume </strong>
		<?php echo $JSONStart ?>XBMC.Mute">Mute</a>
		<?php echo $JSONStart ?>XBMC.Action(VolumeUp)">&uparrow;</a>
		<?php echo $JSONStart ?>XBMC.Action(VolumeDown)">&downarrow;</a>
		<?php echo $JSONStart ?>XBMC.SetVolume(100%,showvolumebar)">Max</a>
	</div>
	<!-- Haven't found the correct code for these yet
	<div id="commands"><strong>Watched </strong>
		<?php echo $JSONStart ?>XBMC.Action(SetWatched)">(un)Mark</a>
		<?php echo $JSONStart ?>XBMC.">Toggle</a>
	</div>
	-->
	<div id="commands"><strong>Video </strong>
		<?php echo $JSONStart ?>XBMC.UpdateLibrary(video)">Update</a>
		<?php echo $JSONStart ?>XBMC.CleanLibrary(video)">Clean</a>
	</div>
	<div id="commands"><strong>Music </strong>
		<?php echo $JSONStart ?>XBMC.UpdateLibrary(music)">Update</a>
		<?php echo $JSONStart ?>XBMC.CleanLibrary(music)">Clean</a>
	</div>

<table align="right" border="0" cellpadding="1" cellspacing="0" draggable="false">
	<tr>
    	<td></td>
    	<td><kbd>&uarr;</kbd></td>
    	<td></td>
    </tr>
	<tr>
    	<td><kbd>&larr;</kbd></td>
    	<td><kbd>&darr;</kbd></td>
    	<td><kbd>&rarr;</kbd></td>
    </tr>
</table> 

<!-- JSON Fix: Start -->
<div id="json"><iframe hidden="yes" id="jsonresponse" name="jsonresponse" src=""></iframe></div>
<!-- JSON Fix: End -->
</body>
</html>