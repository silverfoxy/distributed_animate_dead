<?php

require_once __DIR__ . '/vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;
use PhpAmqpLib\Wire\AMQPTable;

// Define queue names
include './constants.php';
include 'IAnimateDeadWorker.php';
include 'animate_dead/DistributedRaiseDead.php';

class AnimateDeadWorker implements IAnimateDeadWorker {
    protected $callback;
    protected $connection;
    protected $channel;

    public function __construct() {
        // Load env variables
        $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
        $dotenv->load();

        $this->connection = new AMQPStreamConnection('rabbitmq', 5672, $_ENV['RABBITMQ_DEFAULT_USER'], $_ENV['RABBITMQ_DEFAULT_PASS']);
        $this->channel = $this->connection->channel();

        $this->channel->queue_declare(WORKERS_QUEUE, false, true, false, false, false, new AMQPTable(['x-max-priority' => 100]));

        $this->callback = function ($msg) {
            $params = json_decode($msg->body, true);
            echo sprintf(' [+] Received "%s" priority: %d (extended logs: %s)'.PHP_EOL, $msg->get('correlation_id'), $msg->get('priority'), $params['extended_logs_emulation_mode'] ? 'true' : 'false');
            // var_dump($params['extended_logs_emulation_mode']);
            $coverage_info = start_engine($params['init_env'], $params['httpverb'], $params['targetfile'], $this, $params['reanimation_array'], $msg->get('correlation_id'), $params['execution_id'], 4, $params['extended_logs_emulation_mode'], $msg->get('priority'));
            $this->add_termination_task($coverage_info, $params['execution_id']);
            echo " [+] Done\n";
            $msg->delivery_info['channel']->basic_ack($msg->delivery_info['delivery_tag']);
        };
    }

    public function add_termination_task($coverage_info, $execution_id) {
        $task_id = uniqid();
        $params = ['coverage_info' => $coverage_info, 'execution_id' => $execution_id];
        $msg = new AMQPMessage(json_encode($params), ['delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT, 'correlation_id' => $task_id]);

        $this->channel->queue_declare(MANAGER_QUEUE, false, true, false, false);

        $this->channel->basic_publish($msg, '', MANAGER_QUEUE);

        echo sprintf(' [%s] Sent the termination info "%s" to the queue [%s].'.PHP_EOL, date("h:i:sa"), $task_id, MANAGER_QUEUE);
    }

    public function add_reanimation_task($init_env, $httpverb, $targetfile, $reanimationarray, $branch_filename, $branch_linenumber, $line_coverage_hash, $symbol_table_hash, $coverage_info, $execution_id, $extended_logs_emulation_mode, $new_branch_coverage=[], $current_priority=null) {
        $task_id = uniqid();
        // Remove $ini_env['GLOBALS']['GLOBALS'] recursion before json_encode
        unset($init_env['GLOBALS']['GLOBALS']);
        $params = ['init_env' => $init_env,
                   'httpverb' => $httpverb,
                   'targetfile' => $targetfile,
                   'branch_filename' => $branch_filename,
                   'branch_linenumber' => $branch_linenumber,
                   'reanimation_array' => $reanimationarray,
                   'line_coverage_hash' => $line_coverage_hash,
                   'symbol_table_hash' => $symbol_table_hash,
                   'coverage_info' => $coverage_info,
                   'execution_id' => $execution_id,
                   'extended_logs_emulation_mode' => $extended_logs_emulation_mode,
                   'new_branch_coverage' => $new_branch_coverage,
                   'current_priority' => $current_priority];

        $msg = new AMQPMessage(json_encode($params), ['delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT, 'correlation_id' => $task_id]);

        $this->channel->queue_declare(MANAGER_QUEUE, false, true, false, false);
        $this->channel->basic_publish($msg, '', MANAGER_QUEUE);

        echo sprintf(' [%s] Sent the reanimation job "%s" to the queue [%s].'.PHP_EOL, date("h:i:sa"), $task_id, MANAGER_QUEUE);
    }

    public function add_execution_task($priority, $task_id, $init_env, $httpverb, $targetfile, $reanimationarray, $linenumber, $line_coverage_hash, $symbol_table_hash, $execution_id, $extended_logs_emulation_mode) {
        $params = ['init_env' => $init_env,
            'httpverb' => $httpverb,
            'targetfile' => $targetfile,
            'linenumber' => $linenumber,
            'reanimation_array' => $reanimationarray,
            'line_coverage_hash' => $line_coverage_hash,
            'symbol_table_hash' => $symbol_table_hash,
            'execution_id' => $execution_id,
            'extended_logs_emulation_mode' => $extended_logs_emulation_mode];

        $msg = new AMQPMessage(json_encode($params), ['delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT, 'correlation_id' => $task_id, 'priority' => $priority]);

        $this->channel->queue_declare(WORKERS_QUEUE, false, true, false, false, false, new AMQPTable(['x-max-priority' => 100]));
        $this->channel->basic_publish($msg, '', WORKERS_QUEUE);

        echo sprintf(' [%s] Sent the execution job "%s" priority: %d to the queue [%s].'.PHP_EOL, date("h:i:sa"), $task_id, $priority, WORKERS_QUEUE);
    }

    public function get_tasks() {
        $this->channel->basic_qos(null, 1, null);
        $this->channel->basic_consume(WORKERS_QUEUE, '', false, false, false, false, $this->callback, false, new AMQPTable(['x-max-priority' => 100]));

        echo " [*] Waiting for messages. To exit press CTRL+C\n";
        while ($this->channel->is_consuming()) {
            $this->channel->wait();
        }

        $this->channel->close();
        $this->connection->close();
    }
}
if (!defined('ANIMATEDEADWORKER_INCLUDED')) {
    $worker = new AnimateDeadWorker();
    $worker->get_tasks();
}
