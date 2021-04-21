<?php

require_once __DIR__ . '/vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;

// Define queue names
include 'constants.php';
define('ANIMATEDEADWORKER_INCLUDED', 1);
include 'AnimateDeadWorker.php';

class DistributorOfPain {
    protected $callback;
    protected $connection;
    protected $channel;

    public function __construct() {
        // Load env variables
        $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
        $dotenv->load();

        $this->connection = new AMQPStreamConnection('rabbitmq', 5672, $_ENV['RABBITMQ_DEFAULT_USER'], $_ENV['RABBITMQ_DEFAULT_PASS']);
        $this->channel = $this->connection->channel();

        $this->channel->queue_declare(MANAGER_QUEUE, false, true, false, false);

        $this->callback = function ($msg) {
            echo ' [+] Received reanimation state.', PHP_EOL;
            $reanimation_state = json_decode($msg->body, true);
            $reanimation_state_object = new ReanimationState($reanimation_state['init_env'], $reanimation_state['httpverb'], $reanimation_state['reanimation_array'], $reanimation_state['targetfile'], $reanimation_state['linenumber'], $reanimation_state['line_coverage_hash'], $reanimation_state['symbol_table_hash']);
            reanimate($reanimation_state_object, new AnimateDeadWorker());
            echo " [+] Done\n";
        };
    }

    public function get_tasks() {
        $this->channel->basic_qos(null, 1, null);
        $this->channel->basic_consume(MANAGER_QUEUE, '', false, true, false, false, $this->callback);

        echo " [*] Waiting for messages. To exit press CTRL+C\n";
        while ($this->channel->is_consuming()) {
            $this->channel->wait();
        }

        $this->channel->close();
        $this->connection->close();
    }
}

$distributor = new DistributorOfPain();
$distributor->get_tasks();
