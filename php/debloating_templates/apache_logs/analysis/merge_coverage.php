<?php

if ($argc < 2) {
    die('Usage: php merge_coverage.php coverage_files_*.logs');
}
$coverage_files_glob = $argv[1];
echo $coverage_files_glob.PHP_EOL;
$lines_with_coverage = [];

foreach (glob($coverage_files_glob) as $coverage_file) {
    echo 'Processing '.$coverage_file.PHP_EOL;
    $lines = file($coverage_file);
    foreach ($lines as $line) {
        // skip non line numbers
        if (strpos($line, '/home/ubuntu/d' !== 0)) {
            continue;
        }
        if (strpos($line, 'FuncCall' !== false)) {
            continue;
        }
        $lines_with_coverage[] = $line;
    }
    $lines_with_coverage = array_unique($lines_with_coverage);
}
foreach ($lines_with_coverage as $line) {
    echo $line;
}