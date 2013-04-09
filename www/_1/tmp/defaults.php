<?php
$version = 0.1;

/* Verify 'settings.ini' is available, if not, attempt to use defaults below; */
$ini_ini_filename = 'settings.ini';
if (@is_readable($ini_ini_filename)) {
  $ini = parse_ini_file($ini_ini_filename, FALSE);
}
else {
	unset($ini);
}
/* Variables to set if value is missing from settings
 *  Around the site, use the following Syntax for calling your links:
 *		'zzzz' is 4 character abbreviation for AppName
 *		$zzzzhost		= The Host for AppName
 *		$zzzzport		= The Port for AppName
 *		$CallHP_zzzz	= Gives Host:Port format
 *
 *		Additionals:
 *		$comingEpis		= SickBeard's ComingEpisodes
 *
 */

// Hosts and Ports

// TraktTV
if (!isset($ini['_trakt_api'])) { $ini['_trakt_api']  = 'no_api_key'; }
$trakt_api            = $ini['_trakt_api'];

// Plex Media Server
if (!isset($ini['_plex_host'])) { $ini['_plex_host']  = 'localhost'; }
if (!isset($ini['_plex_port'])) { $ini['_plex_port']  = 32400; }
if (!isset($ini['_plex_api'])) { $ini['_plex_api']    = 'no_api_key'; }
$plex_host            = $ini['_plex_host'];
$plex_port            = $ini['_plex_port'];
$plex_api             = $ini['_plex_api'];
$CallHP_PlexApi       = $plexhost  . ":" . $plexport . "/api/" . $plex_api;
$CallHP_PlexSvr       = $plexhost  . ":" . $plexport . "/manage/index.html";

// SabNZBd+
if (!isset($ini['_sabnzbd_host'])) { $ini['_sabnzbd_host']  = 'localhost'; }
if (!isset($ini['_sabnzbd_port'])) { $ini['_sabnzbd_port']  = 8080; }
if (!isset($ini['_sabnzbd_api'])) { $ini['_sabnzbd_api']    = 'no_api_key'; }    		// API Key
$sabnzbd_host         = $ini['_sabnzbd_host'];
$sabnzbd_port         = $ini['_sabnzbd_port'];
$sabnzbd_api          = $ini['_sabnzbd_api'];
$CallHP_Sabnzbd       = $sabnzbd_host . ":" . $sabnzbd_port;

// SickBeard
if (!isset($ini['_sickbeard_host'])) { $ini['_sickbeard_host']  = 'localhost'; }
if (!isset($ini['_sickbeard_port'])) { $ini['_sickbeard_port']  = 8081; }
if (!isset($ini['_sickbeard_api'])) { $ini['_sickbeard_api']    = 'no_api_key'; }  			// API Key
$sickbeard_host       = $ini['_sickbeard_host'];
$sickbeard_port       = $ini['_sickbeard_port'];
$sickbeard_api        = $ini['_sickbeard_api'];
$CallHP_Sickbeard     = $sickbeard_host . ":" . $sickbeard_port;
$CallHP_SickbeardApi  = $sickbeard_host  . ":" . $sickbeard_port . "/api/" . $sickbeard_api;
$sickbeard_comingEpis = 'http://' . $sickbeard_host . ":" . $sickbeard_port . '/comingEpisodes/';

// CouchPotato
if (!isset($ini['_couchpotato_host'])) { $ini['_couchpotato_host']  = 'localhost'; }
if (!isset($ini['_couchpotato_port'])) { $ini['_couchpotato_port']  = 8082; }
if (!isset($ini['_couchpotato_api'])) { $ini['_couchpotato_api']    = 'no_api_key'; }    		// API Key
$couchpotato_host     = $ini['_couchpotato_host'];
$couchpotato_port     = $ini['_couchpotato_port'];
$couchpotato_api      = $ini['_couchpotato_api'];
$CallHP_Couchpotato   = $couchpotato_host . ":" . $couchpotato_port;

// Headphones
if (!isset($ini['_headphones_host'])) { $ini['_headphones_host']    = 'localhost'; }
if (!isset($ini['_headphones_port'])) { $ini['_headphones_port']    = 8184; }
if (!isset($ini['_headphones_api'])) { $ini['_headphones_api']      = 'no_api_key'; }      	// API Key
$headphones_host      = $ini['_headphones_host'];
$headphones_port      = $ini['_headphones_port'];
$headphones_api       = $ini['_headphones_api'];
$CallHP_Headphones    = $headphones_host . ":" . $headphones_port;


// Spotweb
if (!isset($ini['spotweb'])) { $ini['spotweb']              = 'localhost'; }
if (!isset($ini['swport'])) { $ini['swport']                = 80; }
$spothost													= $ini['spotweb'];
$swport														= $ini['swport'];
$CallHP_Spot												= $spothost  . ":" . $swport . "/spotweb/";

// NewzNAB
if (!isset($ini['newznab'])) { $ini['newznab']              = 'localhost'; }
if (!isset($ini['nnport'])) { $ini['nnport']                = 80; }
$newzhost													= $ini['newznab'];
$nnport														= $ini['nnport'];
$CallHP_newz												= $newzhost  . ":" . $nnport . "/newznab/";



// Maraschino
if (!isset($ini['mara'])) { $ini['mara']                    = 'localhost'; }
if (!isset($ini['maraport'])) { $ini['maraport']            = 7000; }
$marahost													= $ini['mara'];
$maraport													= $ini['maraport'];
$CallHP_Mara												= $marahost . ":" . $maraport;

// uTorrent
if (!isset($ini['utor'])) { $ini['utor']                    = 'localhost'; }
if (!isset($ini['utport'])) { $ini['utport']                = 32459; }
$utorhost													= $ini['utor'];
$utorport													= $ini['utport'];
$CallHP_uTor												= $utorhost . ":" . $utorport . "/gui/";

// Transmission
if (!isset($ini['transmission'])) { $ini['transmission']    = 'localhost'; }
if (!isset($ini['tranport'])) { $ini['tranport']            = 51413; }
$tranhost													= $ini['transmission'];
$tranport													= $ini['tranport'];
$CallHP_Tran												= $tranhost . ":" . $tranport;


function writeAppURL($AppCall,$AppName) {
	echo '<a class="classpanel" target="myiframe" href="http://' . $AppCall . '">' . $AppName . '</a>';
}
function writeAppFull($AppURL,$ImageName) {
	echo '<a class="classpanel" target="myiframe" href="http://' . $AppURL . '"><img src="img/apps/' . $ImageName . '.png" /></a>';
}
function writeTopNav($AppName) {
	echo '<a class="classpanel" href="#">' . $AppName . '</a>';
}

// NZB Sites
$NZBMatrix													= 'nzbmatrix.com/nzb.php?';
if (!isset($ini['matrixuser'])) { $ini['matrixuser']		= ''; }
$NZBMatrixUser												= $ini['matrixuser'];
if (!isset($ini['matrixapi'])) { $ini['matrixapi']          = ''; }
$NZBMatrixAPI 												= $ini['matrixapi'];
if (!isset($ini['nzbsuapi'])) { $ini['nzbsuapi']            = ''; }
$NZBsuAPI													= $ini['nzbsuapi'];

// Advanced Settings
if (!isset($ini['charset'])) { $ini['charset']              = 'windows-1251'; }					// NOT in $ini by default
if (!isset($ini['external_css'])) { $ini['external_css']    = 'includes/css/portal.css'; }
if (!isset($ini['description_filename'])) { $ini['description_filename']		= ''; }
if (!isset($ini['cache_dir'])) { $ini['cache_dir']		= ''; }

// Array containing list of filenames which should be omitted during directory loading. Wildcards aren't allowed.
$ini['ignore_files'] = array('.', '..', $ini_ini_filename, $ini['description_filename'], $ini['cache_dir'], basename($_SERVER['SCRIPT_NAME']), '.htaccess', '.htpasswd', 'Thumbs.db', 'error_log', 'access_log', 'cgi-bin', '_notes');

/** Modules Section */
/// Developer Sections
if (!isset($ini['developer'])) { $ini['developer']		= ''; }
$developer	=	$ini['developer'];

/// RSS Feeds
if (!isset($ini['rss_on'])) { $ini['rss_on']		= ''; }
$rsson		=	$ini['rss_on'];

?>
