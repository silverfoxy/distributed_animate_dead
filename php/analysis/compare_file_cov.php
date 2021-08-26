<?php

function entry_point_exists($key, array $array): bool
{
    foreach ($array as $entry) {
        if ($entry['entry_point'] === $key) {
            return true;
        }
    }
    return false;
}

if ($argc < 3) {
    die('Usage: php compare_file_cov.php lessismore_exported_coverage.php[:entry_point] animatedead_line_coverage.txt'.PHP_EOL);
}

$lim_exported_coverage = $argv[1];
$ad_line_coverage = $argv[2];

if (strpos($lim_exported_coverage, ':') !== false) {
    $lim_file = explode(':', $lim_exported_coverage);
    $lim_exported_coverage = $lim_file[0];
    $entry_point = $lim_file[1];
}
// Handle Less is More coverage
if (!file_exists($lim_exported_coverage)) {
    die('Less is More PHP exported coverage does not exist. '.$lim_exported_coverage.PHP_EOL);
}

// defines $covered_files;
include $lim_exported_coverage;

if (isset($entry_point)) {
    if (!entry_point_exists($entry_point, $covered_files)) {
        die(sprintf("'%s' entry_point not found in '%s'.", $entry_point, $lim_exported_coverage));
    }
    $coverage_per_entry = [];

    foreach($covered_files as $coverage_entry) {
        $entry = ['file_name'   => $coverage_entry['file_name'], 
                  'line_number' => $coverage_entry['line_number']];
        $coverage_per_entry[$coverage_entry['entry_point']][] = $entry; 
    }
    $covered_files = $coverage_per_entry[$entry_point];
}


$lim_covered_files = [];
foreach($covered_files as $key => $entry) {
    $lim_covered_files[] = str_replace('/var/www/html/', '', explode(': ', $entry['file_name'])[0]);
}
$lim_covered_files = array_unique($lim_covered_files, SORT_STRING);
// Handle Animate Dead coverage
if (!file_exists($ad_line_coverage)) {
    die('Animate Dead coverage does not exist.'.PHP_EOL);
}
$ad_line_coverage = file($ad_line_coverage, FILE_IGNORE_NEW_LINES);
$ad_covered_files = [];
foreach ($ad_line_coverage as $line) {
    if (strpos($line, ': ') !== false) {
        $filename = str_replace('/home/ubuntu/debloating_templates/', '', explode(': ', $line)[0]);
        $ad_covered_files[] = $filename;
    }
}
$ad_covered_files = array_unique($ad_covered_files, SORT_STRING);
$matching = 0;
$extra = 0;
$missing = 0;
$missing_files = [];
foreach ($lim_covered_files as $filename) {
    if (in_array($filename, $ad_covered_files)) {
        $matching++;
    }
    else {
        $missing++;
        $missing_files[] = $filename;
    }
}
foreach ($ad_covered_files as $filename) {
    if (!in_array($filename, $lim_covered_files)) {
        $extra++;
    }
}

echo sprintf('%d Matching - %d Extra - %d missing'.PHP_EOL, $matching, $extra, $missing);

echo 'Missing files'.PHP_EOL;
foreach ($missing_files as $filename) {
    echo $filename.PHP_EOL;
}