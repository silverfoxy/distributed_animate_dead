<?php
echo $_SERVER["SCRIPT_FILENAME"];
$url = $_SERVER['PHP_SELF'];
$parts = array();
foreach( $_GET as $k=>$v ) {
    $parts[] = "$k=" . urlencode($v);
    }

    $url .= "?" . implode("&", $parts);
echo "\n";
echo $url;
exit;
