<?php
error_reporting(E_ALL ^ E_NOTICE);
$limit_cpu = ini_get('max_execution_time');
$limit_mem = ini_get('memory_limit');
if ($limit_cpu && ($limit_cpu < 60)) { @ini_set('max_execution_time', '60'); }
if ($limit_mem && (rtrim($limit_mem, 'M') < 64)) { @ini_set('memory_limit', '64M'); }

if (strstr(urldecode($_SERVER['REQUEST_URI']), '/../')) { fatal_error('Suspicious query rejected'); }

//$_SERVER['PATH_INFO'] and $_SERVER['PHP_SELF'] variables is very unstable with different php versions and with
//different web servers so it is better to compute them manually
if ( preg_match('|('.$_SERVER['SCRIPT_NAME'].'([^\?]*))\???|', urldecode($_SERVER['REQUEST_URI']), $matches) ) {
	//PATH_INFO is the text between SCRIPT_NAME and QUERY_STRING.
	//$_SERVER['REQUEST_URI'] is not urldecode'd by default on Apache (unlike IIS).
	$SERVER_PHP_SELF = rtrim($matches[1], '/') . '/'; //ensure that we have trailing slash
	$REQUEST_PATH = trim($matches[2], '/');//cut hampering slashes
}
else {
	$SERVER_PHP_SELF = $_SERVER['SCRIPT_NAME'] . '/';
}
if (!$REQUEST_PATH) {
	if ($_GET['path']) { //compatibility mode enabled and we have some path
		$REQUEST_PATH = $_GET['path'];
		$SERVER_PHP_SELF = $_SERVER['SCRIPT_NAME'] . '/' . $REQUEST_PATH . '/';
	}
	else { //we are in the root directory
		$REQUEST_PATH = '.';
	}
}
//$REQUEST_PATH never has starting and trailing slashes
//$SERVER_PHP_SELF always has starting and trailing slashes