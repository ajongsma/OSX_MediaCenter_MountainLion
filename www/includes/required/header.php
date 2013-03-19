<?php ?>
<!DOCTYPE HTML>
<html>
    <head>
        <title>HTPC Portal v<?php echo $version ?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=<?php echo $ini['charset'] ?>"/>
			<?php
			$css_external_path = FALSE;
			$css_external_path = $ini['external_css'];
			if ('' != $css_external_path) {
				if ( preg_match('|^https?://|i', $css_external_path) || 0 == substr_compare($css_external_path, '/', 0, 1) ) {
					$css_is_external = TRUE;
				}
				else if ( is_readable($css_external_path) ) {
					$css_external_path =  ('/' != dirname($_SERVER['SCRIPT_NAME']) ? dirname($_SERVER['SCRIPT_NAME']) : '' ) . '/' . $css_external_path;
					$css_is_external = TRUE;
				}
			}
			if ( $css_is_external ) {
				print('<link href="' . $css_external_path . '" rel="stylesheet" type="text/css">');
				} else { ?> <link rel="stylesheet" type="text/css" href="includes/css/portal.css" /> <?php 
			} ?>
		<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<link rel="shortcut icon" href="includes/images/favicon.ico" />
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'></script>
		<script type="text/javascript" src="includes/javascript/ddaccordion.js">
		/* Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
		 * Visit http://www.dynamicDrive.com for hundreds of DHTML scripts - This notice must stay intact for legal use */
		</script>
		<script type="text/javascript" src="includes/javascript/accordion.js"></script>
		<script type="text/javascript" src="includes/javascript/ddajaxsidepanel.js">
		/* Ajax Side Panel script- © Dynamic Drive (www.dynamicdrive.com)
		 * Visit http://www.dynamicdrive.com/ for this script and 100s more. - This notice must stay intact for legal use */
		</script>

		<!-- Start Apple specific for iDevice's -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<link rel="apple-touch-icon" sizes="72x72" href="includes/images/touch-icon-ipad.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="includes/images/touch-icon-iphone4.png" />
		<!-- The below line is for the Startup Screen if I decide to create one...
			<link rel="apple-touch-startup-image" href=".images/startup.png">
		-->
		<!-- End Apple specific for iDevice's -->
	</head>
