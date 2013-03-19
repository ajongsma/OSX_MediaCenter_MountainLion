<?php
require '../required/defaults.php';
$xbmchost = $ini['xbmc'];
$params = $xbmchost.':9090';
?>
<script type="text/javascript">
function goBack() {
	window.history.go(-1)
}
</script>
<link rel="stylesheet" type="text/css" href="../css/portal.css" />
<div id="nav"><center><input class="classpanel" type="button" value="Go Back" onclick="goBack()" /></center></div>
<?php
require_once 'rpc/TCPClient.php';
try {
    $rpc = new XBMC_RPC_TCPClient($params);
} catch (XBMC_RPC_ConnectionException $e) {
    die($e->getMessage());
}

try {
    if ($rpc->isLegacy()) {
        $response = $rpc->System->GetInfoLabels(array('System.Time'));
    } else {
        $response = $rpc->XBMC->GetInfoLabels(array('labels' => array('System.Time')));
    }
} catch (XBMC_RPC_Exception $e) {
    die($e->getMessage());
}
printf('<p>The current time according to XBMC is %s</p>', $response['System.Time']);

try {
    $response = $rpc->JSONRPC->Introspect();
} catch (XBMC_RPC_Exception $e) {
    die($e->getMessage());
}
print '<p>The following commands are available according to XBMC:</p>';
if ($rpc->isLegacy()) {
    foreach ($response['commands'] as $command) {
        printf('<p><strong>%s</strong><br />%s</p>', $command['command'], $command['description']);
    }
} else {
    foreach ($response['methods'] as $command => $commandData) {
        printf(
            '<p><strong>%s</strong><br />%s</p>',
            $command,
            isset($commandData['description']) ? $commandData['description'] : ''
        );
    }
}