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

require_once('../../plex/Plex.php');
$servers = array(
    'localhost' => array(
        'address' => '127.0.0.1'
    )
);

$plex = new Plex();
$plex->registerServers($servers);

$server = $plex->getServer('localhost');
$client = $plex->getClient('zoe');

?>
<link rel="stylesheet" type="text/css" href="../css/portal.css" />

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
    <td colspan="2" align="center" id="nav"><strong>Get items at the library level</strong></td>
  </tr>
	<tr>
    <td>getOnDeckItems</td>
    <td>&nbsp;</td>
    <td>getRecentlyAddedItems</td>
    <td>&nbsp;</td>
  </tr>
	<tr>
    <td><?php $server->getLibrary()->getOnDeckItems(); ?></td>
    <td><?php echo $server->getLibrary()->getOnDeckItems(); ?></td>
    <td><?php $server->getLibrary()->getRecentlyAddedItems(); ?></td>
    <td><?php echo $server->getLibrary()->getRecentlyAddedItems(); ?></td>
  </tr>
  <tr>
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
  </tr>

</table>
</body>
</html>
