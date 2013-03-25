<?php
require '../required/defaults.php';
require '../required/header.php';

/*
$ini_ini_filename = '../../settings.ini';
if (@is_readable($ini_ini_filename)) {
  $ini = parse_ini_file($ini_ini_filename, FALSE);
}
else {
	unset($ini);
}
*/

require_once('../../plex/Plex.php');
$servers = array(
    'localhost' => array(
        'address' => '127.0.0.1'
    )
);

$plex = new Plex();
$plex->registerServers($servers);

$server = $plex->getServer('localhost');
/* $client = $plex->getClient('clientname'); */

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
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><?php


    /*for ($row = 0; $row < 3; $row++)
    {
      echo "<li><b>The row number $row</b>";
      foreach($server->getLibrary()->getRecentlyAddedItems()[$row] as $key => $value)
      {
          echo "<li>".$server->getLibrary()->getRecentlyAddedItems()[$row]."</li>";
          echo "<li>".$key."</li>";
          echo "<li>".$value."</li>";
      }
    }
    */


    echo "<hr>";

    /*
    $var=$server->getLibrary()->getRecentlyAddedItems();

    echo $var;
    echo print_r($server->getLibrary()->getRecentlyAddedItems()[0],true);
    echo "<hr>";

    foreach($var as $key => $value) {
      echo "<li>key: ".print_r($key) . "<br>";
      echo "<li>val: ".print_r($value);
      echo "<hr>";
      echo print_r($value,true);
      echo "<hr>";
    }
    */

    /* foreach ($server->getLibrary()->getOnDeckItems() as $k => $v) {
      if (is_array($v)) {
      	echo print_r("==> 1 : " . $v)
      	echo $k->Video['title'] . '<br>'; 
      } else {
      	echo print_r("==> 2 : " . $v)
      }
      $arrlength=count($server->getLibrary()->getOnDeckItems());
      echo "<hr>";
      for($x=0;$x<$arrlength;$x++)
      {
        echo "getOnDeckItems: " . $x . "/" . $arrlength . "<br>";
        echo print_r($server->getLibrary()->getOnDeckItems()[$x]);
        echo "<hr>";
      } */
    ?></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td><?php
    /*
      $arrlength=count($server->getLibrary()->getRecentlyAddedItems());
      echo "<hr>";
      for($x=0;$x<$arrlength;$x++)
      {
        echo "getRecentlyAddedItems: " . $x . "/" . $arrlength . "<br>";
        echo print_r($server->getLibrary()->getRecentlyAddedItems()[$x]);
        echo var_dump($server->getLibrary()->getRecentlyAddedItems()[$x]);
        echo "<hr>";
      }
    */
    ?></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

</table>
</body>
</html>
