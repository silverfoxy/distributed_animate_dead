<?php

require_once __DIR__ . '/vendor/autoload.php';

use AnimateDead\Utils;
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Wire\AMQPTable;
use PhpAmqpLib\Exception\AMQPTimeoutException;

// Define queue names
include 'constants.php';
define('ANIMATEDEADWORKER_INCLUDED', 1);
include 'AnimateDeadWorker.php';

class WraithOrchestrator {
    public $connection;
    public $channel;
    public $callback;
    public $worker;
    public $overall_coverage_info = [];
    public $log_filename;

    protected $redis;

    public function __construct($argc, $argv) {
        // Load env variables
        $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
        $dotenv->load();
        $execution_id = uniqid();
        $config_file_path = './animate_dead/config.json';
        $htaccess_bool = Utils::get_htaccess_bool($config_file_path);
        $this->redis = new Redis();
        $this->redis->connect('redis', 6379);
        // Connect to RabbitMQ
        $this->connection = new AMQPStreamConnection('rabbitmq', 5672, $_ENV['RABBITMQ_DEFAULT_USER'], $_ENV['RABBITMQ_DEFAULT_PASS'], '/', false, 'AMQPLAIN', null, 'en_US', 300, 300);
        $this->channel = $this->connection->channel();

        // Create the queue
        $this->channel->queue_declare(WORKERS_QUEUE, false, true, false, false, false, new AMQPTable(['x-max-priority' => 100]));

        $this->worker = new AnimateDeadWorker();

        // Parse cli parameters
        // Sets $this->log_filename
        $daemon = $this->parse_cli_params($argc, $argv, $this->connection, $this->channel, $execution_id, $htaccess_bool);
        $result = $this->log_job_to_db($execution_id, $this->log_filename);
        if ($result !== true) {
            exit('Exiting: Failed to log execution to database.'.PHP_EOL);
        }
        if ($daemon === true) {
            $this->run_daemon();
        }
    }

    protected function run_daemon() {
        $this->channel->queue_declare(MANAGER_QUEUE, false, true, false, false);
        $this->callback = function ($msg) {
            $task_id = $msg->get('correlation_id');
            $message_body = json_decode($msg->body, true);
            // Merge coverage info
            $coverage_info = $message_body['coverage_info'] ?? [];
            $new_branch_coverage = $message_body['new_branch_coverage'] ?? [];
            $parent_priority = $message_body['current_priority'] ?? 0;
            $parent_id = $message_body['parent_id'] ?? 0;
            if (isset($message_body) && array_key_exists('init_env', $message_body)) {
                list($priority, $new_files, $new_lines, $lookahead) = $this->merge_coverage('reanimations', $coverage_info, $new_branch_coverage, $parent_priority);
                // Received a reanimation task
                echo sprintf(' [%s] Received reanimation state for %s.', date("h:i:sa"), $message_body['execution_id'] ?? 'none'), PHP_EOL;
                $reanimation_state = $message_body;
                $reanimation_state_object = new ReanimationState($reanimation_state['init_env'], $reanimation_state['httpverb'], $reanimation_state['reanimation_array'], $reanimation_state['targetfile'], $reanimation_state['branch_linenumber'], $reanimation_state['line_coverage_hash'], $reanimation_state['symbol_table_hash']);
                $this->worker->add_execution_task($priority, $task_id, $parent_id, $reanimation_state_object->init_env, $reanimation_state_object->httpverb, $reanimation_state_object->targetfile, $reanimation_state_object->reanimation_array, $reanimation_state_object->linenumber, $reanimation_state_object->line_coverage_hash, $reanimation_state_object->symbol_table_hash, $message_body['execution_id'], $message_body['extended_logs_emulation_mode']);
                $this->log_execution_to_db($task_id, $parent_id, $priority, $message_body['execution_id'], false, $message_body['branch_filename'], $message_body['branch_linenumber'], $lookahead, $new_files, $new_lines);
            }
            else {
                // Received a termination task
                list($priority, $new_files, $new_lines, $lookahead) = $this->merge_coverage('terminations', $coverage_info, $new_branch_coverage, $parent_priority);
                echo sprintf(' [%s] Received termination info for %s (%d priority).', date("h:i:sa"), $message_body['execution_id'] ?? 'none', $priority), PHP_EOL;
                $this->log_execution_to_db($task_id, $parent_id, $priority, $message_body['execution_id'], true, $message_body['branch_filename'] ?? '', $message_body['branch_linenumber'] ?? 0,  $lookahead, $new_files, $new_lines);
            }
            echo " [+] Done\n";
        };
        $this->channel->basic_qos(null, 50, null);
        $this->channel->basic_consume(MANAGER_QUEUE, '', false, true, false, false, $this->callback);

        echo " [*] Waiting for messages. To exit press CTRL+C\n";
        while ($this->channel->is_consuming()) {
            try {
                $this->channel->wait(null, false, 100);
            }
            catch (Exception $exception) {
                echo 'Queue read timeout exception, retrying in 2 seconds...'.PHP_EOL;
                sleep(2);
            }
        }

        $this->channel->close();
        $this->connection->close();
    }

    protected function log_execution_to_db($task_id, $parent_id, $priority, $execution_id, $termination, $branch_filename, $branch_linenumber, $lookahead, $new_files, $new_lines) {
        $conn = new mysqli('db', 'root', 'root', 'animatedead_executions');
        if ($conn->connect_error) {
            echo sprintf('Failed to log execution [&s] to database (Connection error).'.PHP_EOL, $task_id);
            echo $conn->error.PHP_EOL;
            return;
        }
        $query = $conn->prepare("INSERT INTO executions (id, priority, fk_task_execution_id, parent_id, termination, branch_filename, branch_linenumber, lookahead_coverage, new_files, new_lines) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $query->bind_param("sissisiiii", $task_id, $priority, $execution_id, $parent_id, $termination, $branch_filename, $branch_linenumber, $lookahead, $new_files, $new_lines);
        $result = $query->execute();
        if ($result === false) {
            echo sprintf('Failed to log execution [%s] to database (Query execution error).'.PHP_EOL, $task_id);
            echo $conn->error.PHP_EOL;
        }
        // if ($new_lines !== null) {
        //     $query = $conn->prepare("INSERT INTO debug (filename, linenumber, priority, new_coverage, new_branch_coverage) VALUES (?, ?, ?, ?, ?)");
        //     $new_coverage_json = json_encode($new_lines);
        //     $new_branch_coverage_json = json_encode($new_branch_coverage);
        //     $query->bind_param("siiss", $branch_filename, $branch_linenumber, $priority, $new_coverage_json, $new_branch_coverage_json);
        //     $result = $query->execute();
        //     if ($result === false) {
        //         echo sprintf('Failed to log execution [%s] to database (Query execution error).'.PHP_EOL, $task_id);
        //         echo $conn->error.PHP_EOL;
        //     }
        // }
    }

    protected function log_job_to_db($execution_id, $log_filename) {
        $conn = new mysqli('db', 'root', 'root', 'animatedead_executions');
        if ($conn->connect_error) {
            echo sprintf('Failed to log job [&s] to database (Connection error).'.PHP_EOL, $execution_id);
            return false;
        }
        $query = $conn->prepare("INSERT INTO jobs (execution_id, log_filename) VALUES (?, ?)");
        $query->bind_param("ss", $execution_id, $log_filename);
        $result = $query->execute();
        if ($result === false) {
            echo sprintf('Failed to log job [%s] to database (Query execution error).'.PHP_EOL, $execution_id);
            echo $conn->error.PHP_EOL;
            return false;
        }
        return true;
    }

    /**
     * @param string $datastore value from ['reanimations', 'terminations']
     * @param array $new_coverage_info
     * @param array $new_branch_coverage
     * @param int $parent_priority
     * @return array
     */
    protected function merge_coverage(string $datastore, array $new_coverage_info, array $new_branch_coverage = [], int $parent_priority = 0) {
        // Count overall coverage
        $new_files = 0;
        $new_lines = 0;

        foreach ($new_coverage_info as $filename => $lines) {
            $line_count = $this->redis->sAddArray("{$datastore}_{$filename}", array_keys($lines));;
            $new_lines += $line_count;
            if ($line_count > 0) {
                $new_files++;
            }
            // $total_covered_lines_in_covered_files += $this->redis->sCard($filename);
        }
        $new_branch_lines = 0;
        if ($new_branch_coverage !== []) {
            foreach ($new_branch_coverage as $filename => $lines) {
                foreach ($lines as $line) {
                    if ($this->redis->sIsMember("{$datastore}_{$filename}", $line) === false) {
                        $new_branch_lines++;
                    }
                }
            }
        }
        // $priority = ((double)$new_lines / $total_covered_lines_in_covered_files) * 100 + $new_branch_lines;
        $priority = $new_lines * 10 + $new_branch_lines + $parent_priority / 2;
        $priority = min($priority, 100);
        if ($priority < 1) {
            if ($new_lines > 0 || $new_branch_lines > 0) {
                // If any new lines are or will be covered, set the priority to a minimum of 1.
                $priority = 1;
            }
        }
        $lookahead = $new_branch_lines;

        return [(int)$priority, $new_files, $new_lines, $lookahead];
    }

    protected function parse_cli_params(int $argc, array $argv, $connection, $channel, $execution_id, $htaccess_bool) {
        $usage='Usage: php orchestrator.php -l access.log -e extended_logs.log -r application/root/dir -u uri_prefix [-d -i ip_addr -v verbosity --reanimation id]'.PHP_EOL;
        if (isset($argc))
        {
            // Parse command line arguments
            $options=getopt('l:r:u:i:e:dv::t:',['log:', 'root_dir:', 'uri_prefix:', 'ip_addr::', 'verbosity::', 'reanimation::']);
            if ((!isset($options['l']) && (!isset($options['e']))) || !isset($options['r']) || !isset($options['u'])) {
                if (isset($options['d'])) {
                    // Run as daemon
                    return true;
                }
                else {
                    die($usage);
                }
            }
            // Create parameters
            $params = ['log' => $options['l'] ?? null,
                'extended_logs' => $options['e'] ?? null,
                'root_dir' => $options['r'],
                'uri_prefix' => $options['u'],
                'ip_address' => $options['i'],
                'verbosity' => $options['v'] ?? 1,
                'reanimation' => $options['reanimation'] ?? null];
            // Parse the logs and extract tasks
            $this->log_filename = basename($params['log'] ?? $params['extended_logs']);
            // Parse logs
            $application_root_dir = $params['root_dir'];
            $uri_prefix = $params['uri_prefix'];
            $flows = [];
            if (isset($params['ip_address'])) {
                $filter_ip = $params['ip_address'];
            }
            else {
                $filter_ip = '';
            }
            if (isset($params['reanimation'])) {
                $reanimation_array = json_decode(file_get_contents(sprintf('animate_dead/logs/reanimation_logs/%s_reanimation_log.txt', $params['reanimation'])), true);
            }
            // Normal logs
            if (isset($params['log'])) {
                $log_file_path = $params['log'];
                $flows = parse_logs($log_file_path, $application_root_dir, $uri_prefix, $filter_ip, $htaccess_bool);
                foreach ($flows as $flow) {
                    foreach ($flow as $log_entry) {
                        $verb = $log_entry->verb;
                        $target_file = $log_entry->target_file;
                        $parameters = $log_entry->query_string_array;
                        $uri = $log_entry->path;
                        $init_env['_SESSION'] = [];
                        $init_env['_COOKIE'] = [];
                        $init_env['_SERVER']['REQUEST_METHOD'] = $verb;
                        $init_env['_SERVER']['REQUEST_URI'] = $uri;
                        $init_env['_SERVER']['SCRIPT_FILENAME'] = $init_env['_SERVER']['PHP_SELF'] = $target_file;
                        $init_env['_SERVER']['SCRIPT_NAME'] = $init_env['_SERVER']['SCRIPT_FILENAME'] = $init_env['_SERVER']['PATH_TRANSLATED'] = "/" . basename($target_file);
                        $init_env['_SERVER']['HTTP_REFERER'] = $log_entry->referer;
                        $init_env['_GET'] = $parameters ?? [];
                        $init_env['_POST'] = [];
                        $init_env['_FILES'] = [];
                        $init_env['_REQUEST'] = array_merge($init_env['_GET'], $init_env['_POST'], $init_env['_COOKIE']);
                        if (isset($parameters['reanimation']))  {
                            $this->worker->add_reanimation_task($init_env, $verb, $target_file, $reanimation_array ?? [], '', 0, '', '', [], $execution_id, 0, 0, false, [], 100);
                        }
                        else {
                            $this->worker->add_execution_task(100, uniqid(), 0, $init_env, $verb, $target_file, [], 0, '', '', $execution_id, false);
                        }
                    }
                }
            }
            else {
                $log_file_path = $params['extended_logs'];
                $flows = parse_extended_logs($log_file_path);
                $session_variables = [];
                $cookies = [];
                foreach ($flows as $log_entry) {
                    $verb = $log_entry['request_method'];
                    $target_file = $params['root_dir'] . str_replace($params['uri_prefix'], '', $log_entry['script_filename']);
                    // Removing non utf characters
                    if (isset($log_entry['session'])) {
                        array_walk($log_entry['session'], function(&$value, $key) {
                            $value = 'dummy';
                        });
                    }
                    if (isset($log_entry['cookie'])) {
                        array_walk($log_entry['cookie'], function (&$value, $key) {
                            $value = 'dummy';
                        });
                    }
                    $init_env['_SESSION'] = $log_entry['session'] ?? [];
                    $init_env['_COOKIE'] = $log_entry['cookie'] ?? [];
                    $init_env['_SERVER']['REQUEST_METHOD'] = $verb;
                    $init_env['_SERVER']['SCRIPT_FILENAME'] = $init_env['_SERVER']['PHP_SELF'] = $target_file;
                    $init_env['_SERVER']['SCRIPT_NAME'] = $init_env['_SERVER']['SCRIPT_FILENAME'] = $init_env['_SERVER']['PATH_TRANSLATED'] = "/" . basename($target_file);
                    $init_env['_GET'] = $log_entry['get'] ?? [];
                    $init_env['_POST'] = $log_entry['post'] ?? [];
                    $init_env['_FILES'] = $log_entry['files'] ?? [];
                    $init_env['_REQUEST'] = array_merge($init_env['_GET'], $init_env['_POST'], $init_env['_COOKIE']);
                    if (isset($params['reanimation']))  {
                        $this->worker->add_reanimation_task($init_env, $verb, $target_file, $reanimation_array ?? [], '', 0, '', '', [], $execution_id, 0, true, [], 100);
                    }
                    else {
                        $this->worker->add_execution_task(100, uniqid(), 0, $init_env, $verb, $target_file, [], 0, '', '', $execution_id, true);
                    }
                }
            }
            if (isset($options['d'])) {
                // Run as daemon
                return true;
            }
            else {
                return false;
            }
        }
        else {
            if (isset($options['d'])) {
                // Run as daemon
                return true;
            }
            else {
                die($usage);
            }
        }
    }
}

$wraith = new WraithOrchestrator($argc, $argv);
