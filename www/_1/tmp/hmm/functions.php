<?php
function data_uri($file, $mime) {
	$contents	= file_get_contents($file);
	$base64		= base64_encode($contents); 
	return ('data:' . $mime . ';base64,' . $base64);
}
?>
