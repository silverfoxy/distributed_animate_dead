<?php

require __DIR__ . '/vendor/autoload.php';

use Siteworx\ProgressBar\CliProgressBar;

if ($argc < 3) {
    die('Usage: php merge_coverage.php coverage_files_*.logs destination_logs.txt');
}
$coverage_files_glob = $argv[1];
$destination_logs = $argv[2];
$lines_with_coverage = [];

$matched_files = new GlobIterator($coverage_files_glob);
$total_files = $matched_files->count();

$progress_bar = new CliProgressBar($total_files, 0);
$progress_bar->displayTimeRemaining()->display();

foreach ($matched_files as $coverage_file) {
    $progress_bar->setDetails($coverage_file);
    $progress_bar->progress();

    $lines = file($coverage_file);
    foreach ($lines as $line) {
        // skip non line numbers
        if (strpos($line, '/home/ubuntu/d')===false) {
            continue;
        }
        if (strpos($line, 'FuncCall')!== false) {
            continue;
        }
        $lines_with_coverage[] = $line;
    }
    $lines_with_coverage = array_unique($lines_with_coverage);
}
$progress_bar->end();
echo '[+] Writing line coverage logs to ' . $destination_logs . PHP_EOL;
file_put_contents($destination_logs, implode('', $lines_with_coverage));

