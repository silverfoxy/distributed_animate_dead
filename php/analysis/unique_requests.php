<?php

$extended_logs = file_get_contents('./pma470_extendedlogs.log');
$lines = explode("\n", $extended_logs);
$serialized_line = '';
$unique_files = [];
foreach($lines as $line) {
    if ($line !== '----') {
        if (strlen($serialized_line) > 0) {
            $serialized_line .= "\n";
        }
        $serialized_line .= $line;
    }
    else {
        $entry = unserialize($serialized_line);
        if ($entry === false) {
            echo $entry.PHP_EOL;
            sleep(5);
        }
        $filename = $entry['script_filename'];
        if (!in_array($filename, $unique_files)) {
            $unique_files[] = $filename;
        }
        $serialized_line = '';
    }
}
print_r($unique_files);