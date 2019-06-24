<?php

$phantom_cmd = "/opt/phantomjs/phantomjs --ignore-ssl-errors true /opt/phantomjs/render.js";

if(isset($_GET['url']) && isset($_GET['cookies'])) {

	header("Content-type: image/png");
	$url_ext = '';
	foreach($_GET as $key => $value) {
		if($key != "cookies" && $key != "url") {
			$url_ext .= '&'.$key."=".$value;
		}
	}
	$output = shell_exec("$phantom_cmd \"$_GET[url]$url_ext\" $_GET[cookies]");
	echo base64_decode($output);

}
else {
    http_response_code('405');
    echo "<h1 align=\"center\">HTTP 405 Method not allowed</h1>";
}

?>