<?php

interface IAnimateDeadWorker
{
    public function add_reanimation_task($init_env, $httpverb, $targetfile, $reanimationarray, $branch_filename, $branch_linenumber, $line_coverage_hash, $symbol_table_hash, $coverage_info, $execution_id);

    public function add_execution_task($priority, $task_id, $init_env, $httpverb, $targetfile, $reanimationarray, $linenumber, $line_coverage_hash, $symbol_table_hash, $execution_id);
}