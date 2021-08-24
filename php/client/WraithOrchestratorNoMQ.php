<?php

require_once __DIR__ . '/vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

// Define queue names
define('ANIMATEDEADWORKER_INCLUDED', 1);
include 'AnimateDeadWorkerMock.php';

class WraithOrchestratorNoMQ {
    public $worker;

    public function __construct($argc, $argv) {
        $this->worker = new AnimateDeadWorkerMock();
        // Parse cli parameters
        $this->parse_cli_params($argc, $argv);
    }

    protected function parse_cli_params(int $argc, array $argv) {
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
                'verbosity' => $options['v'] ?? 4,
                'reanimation' => $options['reanimation'] ?? null];
            // Parse the logs and extract tasks
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
                // Normalize paths from docker to local
                // array_walk($reanimation_array, function(&$value, $key) {
                //     $value['current_file'] = str_replace('/home/ubuntu', '/mnt/c/Users/baminazad/Documents/Pragsec/distributed_animate_dead/php', $value['current_file']);
                // });
            }
            // Normal logs
            if (isset($params['log'])) {
                $log_file_path = $params['log'];
                $flows = parse_logs($log_file_path, $application_root_dir, $uri_prefix, $filter_ip);
                foreach ($flows as $flow) {
                    foreach ($flow as $log_entry) {
                        $verb = $log_entry->verb;
                        $target_file = $log_entry->target_file;
                        $status_code = $log_entry->status;
                        $parameters = $log_entry->query_string_array;

                        $init_env['_SESSION'] = [];
                        $init_env['_COOKIE'] = [];
                        $init_env['_SERVER']['REQUEST_METHOD'] = $verb;
                        $init_env['_GET'] = $parameters ?? [];
                        $init_env['_POST'] = [];
                        $init_env['_REQUEST'] = array_merge($init_env['_GET'], $init_env['_POST'], $init_env['_COOKIE']);

                        $reanimation_state = new ReanimationState($init_env, $verb, $reanimation_array ?? [], $target_file, 0, '', '');
                        reanimate($reanimation_state, $this->worker);
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
                    $target_file = $params['root_dir'] . str_replace('/var/www/html/phpMyAdmin-4.7.0-all-languages/', '', $log_entry['script_filename']);
                    // Removing non utf characters
                    array_walk($log_entry['session'], function(&$value, $key) {
                        $value = 'dummy';
                    });
                    array_walk($log_entry['cookie'], function(&$value, $key) {
                        $value = 'dummy';
                    });
                    $init_env['_SESSION'] = $log_entry['session'] ?? [];
                    $init_env['_COOKIE'] = $log_entry['cookie'] ?? [];
                    $init_env['_SERVER']['REQUEST_METHOD'] = $verb;
                    $init_env['_GET'] = $log_entry['get'] ?? [];
                    $init_env['_POST'] = $log_entry['post'] ?? [];
                    $init_env['_REQUEST'] = array_merge($init_env['_GET'], $init_env['_POST'], $init_env['_COOKIE']);
                    $reanimation_state = new ReanimationState($init_env, $verb, $reanimation_array ?? [], $target_file, 0, '', '');
                    reanimate($reanimation_state, $this->worker);
                }
            }
        }
    }
}

$wraith = new WraithOrchestratorNoMQ($argc, $argv);