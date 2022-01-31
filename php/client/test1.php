<?php

$server["SCRIPT_FILENAME"] = "/var/www/html/api.php";
$server["SCRIPT_NAME"] = "api.php";
$server["REQUEST_URI"] = "/api/status";
$sfilename = $server["SCRIPT_FILENAME"]; // pathname
$sfile = substr($sfilename, strrpos($sfilename, "/") + 1); #/var/www/html/api.php --- sfile = api.php

$sname = $server["SCRIPT_NAME"]; // URL-decoded sname = api.php
$sname_slash = strrpos($sname, "/"); #sname_slash = null
if (substr($sname, $sname_slash + 1) !== $sfile) {
if ($sname === "" || $sname[strlen($sname) - 1] !== "/") {
$sname .= "/";
}
$sname_slash = strlen($sname) - 1; #slash = 6
}

$request_uri = $uri = $server["REQUEST_URI"]; // URL-encoded
if (substr($uri, 0, $sname_slash) === substr($sname, 0, $sname_slash)) {
$uri_slash = $sname_slash;
} else {
// URL-encoded prefix != URL-decoded prefix
for ($nslash = substr_count(substr($sname, 0, $sname_slash), "/"),
$uri_slash = 0;
$nslash > 0; --$nslash) {
$uri_slash = strpos($uri, "/", $uri_slash + 1);
}
}
if ($uri_slash === false || $uri_slash > strlen($uri)) {
$uri_slash = strlen($uri);
}

$site_path = substr($uri, 0, $uri_slash) . "/";

// separate $page, $path, $query
$uri_suffix = substr($uri, $uri_slash);
// Semi-URL-decode $uri_suffix, only decoding safe characters.
// (This is generally already done for us but just to be safe.)
$uri_suffix = preg_replace_callback('/%[2-7][0-9a-f]/i', function ($m) {
$x = urldecode($m[0]);
/** @phan-suppress-next-line PhanParamSuspiciousOrder */
if (ctype_alnum($x) || strpos("._,-=@~", $x) !== false) {
return $x;
} else {
return $m[0];
}
}, $uri_suffix);
preg_match(',\A(/[^/\?\#]*|)([^\?\#]*)(.*)\z,', $uri_suffix, $m);
if ($m[1] !== "" && $m[1] !== "/") {
$page = substr($m[1], 1);
} else {
$page = $index_name;
}
if (($pagelen = strlen($page)) > 4
&& substr($page, $pagelen - 4) === ".php") {
$page = substr($page, 0, $pagelen - 4);
}
$path = $m[2];
$shifted_path = "";
$query = $m[3];

// detect $site_path_relative
$path_slash = substr_count($path, "/");
if ($path_slash) {
$site_path_relative = str_repeat("../", $path_slash);
} else if ($uri_slash >= strlen($uri)) {
$site_path_relative = $site_path;
} else {
$site_path_relative = "";
}

// set $base_path
$base_path = $site_path;
$base_path_relative = $site_path_relative;

#if (isset($server["HOTCRP_PHP_SUFFIX"])) {
#$php_suffix = $server["HOTCRP_PHP_SUFFIX"];
#} else if (!function_exists("apache_get_modules")
#|| array_search("mod_rewrite", apache_get_modules()) !== false) {
#$php_suffix = "";
#} else {
#$php_suffix = ".php";
#}
#}
