<?php

require_once __DIR__ . '/vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

// Define queue names
include './constants.php';
include 'animate_dead/DistributedRaiseDead.php';
include 'animate_dead/vendor/silverfoxy/malmax/php-emul/ReanimationEntry.php';

class TestReanimation
{
    protected $callback;
    protected $connection;
    protected $channel;

    public function __construct()
    {
        // Load env variables
        $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
        $dotenv->load();

        $this->connection = new AMQPStreamConnection('rabbitmq', 5672, $_ENV['RABBITMQ_DEFAULT_USER'], $_ENV['RABBITMQ_DEFAULT_PASS']);
        $this->channel = $this->connection->channel();

        $this->channel->queue_declare(MANAGER_QUEUE, false, true, false, false);

        $params = unserialize(file_get_contents('/home/ubuntu/client/task.ser'));
        $msg = new AMQPMessage(json_encode($params), ['delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT]);

        $this->channel->queue_declare(MANAGER_QUEUE, false, true, false, false);
        $this->channel->basic_publish($msg, '', MANAGER_QUEUE);

        echo sprintf('[+] Sent the reanimation job "%s" to the queue [%s].' . PHP_EOL, $line_coverage_hash . '_' . $symbol_table_hash, MANAGER_QUEUE);
    }
}
$test = new TestReanimation();