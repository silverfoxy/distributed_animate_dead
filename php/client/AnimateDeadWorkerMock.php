<?php

require_once __DIR__ . '/vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

// Define queue names
include 'constants.php';
include 'IAnimateDeadWorker.php';
include 'animate_dead/DistributedRaiseDead.php';

class AnimateDeadWorkerMock implements IAnimateDeadWorker {

    public function add_reanimation_task($init_env, $httpverb, $targetfile, $reanimationarray, $branch_filename, $branch_linenumber, $line_coverage_hash, $symbol_table_hash, $coverage_info, $execution_id) {
        echo sprintf(' [+] Fake sent the reanimation job "Dummy" to the queue [%s].'.PHP_EOL, MANAGER_QUEUE);
    }

    public function add_execution_task($priority, $task_id, $init_env, $httpverb, $targetfile, $reanimationarray, $linenumber, $line_coverage_hash, $symbol_table_hash, $execution_id) {
        echo sprintf(' [+] Fake sent the execution job "%s" to the queue [%s].'.PHP_EOL, $task_id, WORKERS_QUEUE);
    }
}