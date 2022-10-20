# Distributed *AnimateDead*
## Installing *AnimateDead*
Release package available at https://github.com/silverfoxy/distributed_animate_dead/releases/tag/v1.0  
After downloading the package, run `docker-compose up -d` to spin up the machines.
### Specs
The [default docker-compose file](https://github.com/silverfoxy/distributed_animate_dead/blob/master/docker-compose.yml) spins up **4 master** and **20 worker** replicas. 
A good rule of thumb is to have one worker per CPU core (but not a hard requirement).
### Services 
> **Warning**  
> Do not expose *AnimateDead* docker containers to the internet before securing them first. By default, they only listen to local ports.
- run: Used to start a new analysis.
- master: Hosts the orchestrator nodes that merge and prioritize tasks.
- worker: Runs *AnimateDead* instances.
- debug_worker: worker instance that runs XDebug. Can be used for debugging tasks on the queue.
- RabbitMQ (http://localhost:15672 rabbitmq-7d9qghuwqh9d87hgq9w): Hosts the queue of tasks.
- phpmyadmin (http://localhost:8080 root-root): Access and management of *executions* database.
- grafana (http://localhost:3000 admin-admin): Reporting panels.
- db: Database of execution logs.
- redis: Datastore for code-coverage.
## Analyzing Web Applications
*AnimateDead* requires the **web application source code** after installation (i.e., with a valid configuration file) along with **web server log files**. 
It is advised to run the entry points from log files individually.  
- Web applications are available at: [php/debloating_templates](https://github.com/silverfoxy/animate_dead_coverage_logs/)
- Web server log files are available at: [php/analysis/apache_log_files](https://github.com/silverfoxy/animate_dead_logs)

Examples of analyzing entry points with normal and extended logs:
Get a shell into the run docker using `docker-compose run bash` and then run the following commands:

**phpMyAdmin [Extended logs]**  
`php WraithOrchestrator.php -e="../debloating_templates/apache_logs/phpmyadmin470_extended_logs/pma470_tbl_change_extended_logs.txt" -r ../debloating_templates/phpMyAdmin-4.7.0-all-languages/ -u /var/www/html/phpMyAdmin-4.7.0-all-languages/ -i="172.24.0.1"
`

**WordPress [Extended logs]**  
`php WraithOrchestrator.php -e="../debloating_templates/apache_logs/wordpress4622_extended_logs/wp_4622_extended_logs_index_get.txt" -r ../debloating_templates/WordPress-4.6.22/ -u /var/www/html/wordpress-4.6.22/ -i="172.24.0.1"`

**HotCRP [Extended logs]**  
`php WraithOrchestrator.php -e="../debloating_templates/apache_logs/hotcrp/extended_index_1.log"  -r ../debloating_templates/hotcrp/ -u /var/www/html/hotcrp/ -i="172.21.0.1"`

**FluxBB [Normal logs]**  
`php WraithOrchestrator.php -l="../debloating_templates/apache_logs/fluxbb/index.log"  -r ../debloating_templates/fluxbb/ -u /fluxbb/ -i="172.21.0.1"`

Then watch the progress over grafana and merge the overall coverage by running the merge script in the **run** container under analysis directory (Mind the quotes around log file path wild card):  
`php merge_coverage.php "../php/client/animate_dead/logs/*_coverage_logs.txt" overallcoverage.txt`

You can compare the code-coverage with a baseline (e.g., dynamic code-coverage from [Less is More](https://lessismore.debloating.com/)) using the following command:  
`php compare_file_cov.php lessismore_exported_coverage.php animatedead_coverage.txt`
### Verifying the Correct Execution of *AnimateDead*
- Check the logs using `docker-compose logs -f worker`.
- Check for execution logs under `php/client/animate_dead/logs/`
## Debloating Web Applications
*AnimateDead* provides the code-coverage for each entry point in web applications. 
This information can be used in out [Jupyter notebook environment to debloat web applications](https://github.com/silverfoxy/animatedead_data_analysis/blob/master/coverage_analysis.ipynb) and remove unused code: https://github.com/silverfoxy/animatedead_data_analysis

Follow the steps to setup the docker environment for the notebook in its repository documents.
## Building from source / Dev environment
1. Clone *Distributed AnimateDead*'s Git repository and its submodules:  
`git clone --recurse-submodules -j8 git@github.com:silverfoxy/distributed_animate_dead.git`
2. Install dependencies using `./install_deps.sh`.
3. Copy the configuration file over:  
`cp php/client/animate_dead/config.sample.json php/client/animate_dead/config.json`
## Motivation and Design
### Recommended Reading
Here are some documents that will give you the background information that will be really helpful throughout this project:  
- **PHP-Parser َsage**: [Getting started with PHP-CFG](https://www.silverf0x00.com/getting-started-with-php-cfg/) (Even though we do not directly use PHP-CFG in our project, it is still beneficial to read this blog post.)
- **PHP-Parser Documents**: https://github.com/nikic/PHP-Parser/tree/master/doc
- **Less is More Paper**: [< is > : Quantifying the Security Benefits of Debloating Web Applications](https://lessismore.debloating.com/)
- **MalMax Paper**: https://yonghwi-kwon.github.io/data/malmax_ccs19.pdf
- **Cubismo Paper**: https://yonghwi-kwon.github.io/data/cubismo_acsac19.pdf (Uses the same architecture of MalMax with a small twist.)
- **Saphire Paper**: [Saphire : Sandboxing PHP Applications with Tailored System Call Allowlists](https://saphire.debloating.com/)  (Not directly related to this project, but gives you a good background on the challenges of static analysis of PHP code and its dynamic constructs, such as dynamic includes, and dynamic class/function names.)
### *AnimateDead* Modules
This project consists of 3 main modules. Module dependency looks like this:

| Module                                                                                                                                                                                                                            |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Distributed AnimateDead**: Wrapper around AnimateDead to support distributed and parallel execution of multiple execution paths using a message-queue/worker architecture.                                                      |
| **AnimateDead**: Wrapper code for MalMax, translating entry points from Apache log files to executable code for MalMax (e.g., GET /login.php?username=bob → Run ./WordPress/login.php and populate $_GET['username'] with “bob”.) |
| **MalMax**: PHP emulator capable of parsing and running concrete PHP code. Extended to support symbolic variables (variables with unknown value at emulation time.)                                                               |

### MalMax
This module was published as part of ["MalMax: Multi-Aspect Execution for Automated Dynamic Web Server Malware Analysis"](https://yonghwi-kwon.github.io/data/malmax_ccs19.pdf) paper from CCS 2019 conference. Originally, the authors of this tool used it to uncover the obfuscation layer of malware injected into WordPress plugins. We are extending this emulator to support more PHP applications as well as to understand and emulate PHP code with Symbolic variables which have unknown value at emulation time.

#### Contributions to MalMax
The original copy of MalMax only supported a limited list of PHP features and opcodes, which was enough for its original use case. But since in this project, our goal is not just to focus on the execution of a single PHP file, but rather the whole execution flow from an entry point, we made frequent changes and added a large list of features to original MalMax.

#### Support for symbolic variables
In order to run PHP code with symbolic variables (i.e., variables that we do not know their value), we needed to update the logic inside MalMax. For instance, an if condition for which the condition has a symbolic value, cannot determine the execution path. As a result, the execution engine should fork the execution such that both the branch where the condition is “true” and the branch where the condition is “false” are taken and analyzed.

#### Support for missing opcodes
We use PHP-Parser library to get the AST from PHP code. Gradually we added support for all PHP opcodes to MalMax. Occasionally we may identify specific use cases of these opcodes that are not supported by MalMax that we have to implement.

#### Emulating the execution environment
Certain APIs within PHP interact with the outside world. Some of these APIs cannot operate on Symbolic variables. One main example of this is the database API which is frequently used within web applications. Based on the observation that we cannot run queries with symbolic (read: unknown) variables, we decided to abstract away the whole database. So all queries to the database now return a symbol. From time to time, we may identify a new API and its usage that we decide to model in our emulator.

Another example of this are the [PHP builtin functions](https://www.php.net/manual/en/indexes.functions.php). These functions are defined by the PHP engine itself, or added by PHP extensions. For now, builtin functions are invoked natively with concrete values, but always return a Symbol whenever the function call arguments are symbolic. We also have the ability to hook into the builtin functions that change the state of the emulator. These hooks are called mocks. For instance, `define` API defines a new constant variable. As a result, instead of passing this call to the PHP engine, we add this constant to the symbol table inside our emulator by `define_mock` class.

### Main modules
Now we briefly discuss the important modules within MalMax in order to understand their relationships.

#### [Entry point - PHPAnalyzer.php](https://github.com/silverfoxy/malmax/blob/master/phpanalyzer.php)
By instantiating the PHPAnalyzer class defined in PHPAnalyzer.php, we can start the emulation of PHP code. Before running this code, we need to set up its environment. For instance, we need to tell the emulator which variables, functions, and APIs are symbolic. start($file) function within PHPAnalyzer takes a PHP file as input and starts executing it. PHPAnalyzer itself hands the control to emulator.php and also extends the OOEmulator class.

#### [php-emul/emulator.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/emulator.php)
This class defines a start() method, which is the entry point to running new PHP files. The flow is "start($file) → run_file($file) → [run_code($ast)](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator.php#L1257)". From here, "[run_code()](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator.php#L1257)" takes an AST, iterates over its Nodes and calls "[run_statement($node)](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator-statement.php#L46)" which is defined in [emulator-statements.php](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator-statement.php).

#### [php-emul/emulator-statements.php](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator-statement.php)
As the name suggests, this "[trait](https://www.php.net/manual/en/language.oop5.traits.php)", which is added to the emulator itself, defines functions that deal with PHP statements. [Statements](https://github.com/nikic/PHP-Parser/tree/master/lib/PhpParser/Node/Stmt) are specific node types as defined by the PHP-Parser library. These are language constructs such as “If”, “Class”, “TryCatch”, etc. Sometimes, in order to emulate the outcome of these statements, we need to evaluate expressions. Handling expressions is performed by [emulator-expression.php](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator-expression.php).

#### [php-emul/emulator-expression.php](https://github.com/silverfoxy/malmax/blob/a3f30c365253c81a9b6a8ad6344aefbbbb757326/php-emul/emulator-expression.php)
Expressions are a different type of node produced by the PHP-Parser. Expressions are the constructs that return something, in contrast, statements do not necessarily return a value after their execution. Some examples of PHP expressions are “and, or, cast, funcCall, etc.” For instance, to decide the outcome of an “if statement”, we need to evaluate the expression which is the condition of the if, and this is done by this file.  
The general structure of most of these files are similar. There is a giant if/else or switch/case statement, which checks the Node type of the current node on the AST and applies the corresponding logic to it.

#### [php-emul/emulator-functions.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/emulator-functions.php)
For function call expressions, we hand the execution of the application to emulator-functions.php file. Resolving function arguments, the execution context and variable scopes and even resolving the function calls to their function body is performed here. Depending on the type of function call, we may end up calling different methods from this file. For instance, static calls or calls to builtin PHP functions are handled differently compared to normal function calls.

#### [php-emul/emulator-variables.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/emulator-variables.php)
This file interfaces the variable operations with the Symbol Table of the emulator. Setting or fetching variable values are some functions performed within this file. This file includes [SymbolicVariable.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/SymbolicVariable.php) which adds the definition of SymbolicVariable type to MalMax.

#### [php-emul/emulator-errors.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/emulator-errors.php)
This file is responsible for handling the active try/catch blocks and exception handling.

#### [php-emul/oo.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/oo.php)
Object-oriented and class related operations such as "instantiating a new object" or "getting the parents of a class" and "calling class methods" are among the functions that are defined within this file.

#### [php-emul/oo-methods.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/oo-methods.php)
Similar to emulation-functions.php, this file handles method calls (functions that are defined within classes).

#### [php-emul/LineLogger.php](https://github.com/silverfoxy/malmax/blob/master/php-emul/LineLogger.php)
In previous work, we used XDebug to record line level code coverage and remove any unused file/function to debloat PHP applications. In this project, the idea is to use an emulator to extract the executable paths within an application based on entry points. Ultimately, we plan to use the line coverage information to debloat the application. As a result, we include this module, which is called whenever a Node within the AST is being executed to log the starting and ending line numbers of each Node.

#### [mocks](https://github.com/silverfoxy/malmax/tree/master/php-emul/mocks)
n order to hook into the execution of builtin functions of PHP, we defined mocks. Mocks should be named similar to the function they are trying to override (e.g., to override array_key_exists we define array_key_exists_mock. The parameters are an instance of the emulator ($emul) followed by the original parameters, as expected by the builtin functions. To add a mock for a new builtin function, we always refer to the PHP documents to extract these parameters. For instance, the parameters for array_key_exists are:

($emul, $key, $array): returns true if $key exists in the $array keys. Sometimes we perform an operation at the level of the emulator and then call the original builtin function, and sometimes we handle everything at the emulator itself.

### [*AnimateDead*](https://github.com/silverfoxy/AnimateDead)
This module parses the Apache access_log files and translates them to entry points and emulator states that MalMax can understand. MalMax is one of the dependencies of AnimateDead (included under vendor/silverfoxy/malmax).

Since the emulator is running as a CLI application, certain environment related variables and constants may return a different value compared to a PHP script that is invoked from Apache. In order to emulate an environment such that the web application under emulation thinks it is running by Apache, we override certain PHP constants. These constants are extracted from a running Apache instance and stored as a serialized file which is then loaded into the emulator.

#### [constants.ser](https://github.com/silverfoxy/AnimateDead/blob/master/PHP56_constants.ser)
For older applications, we have to emulate a PHP5.6 environment and for recent applications, we emulate a PHP7.4 environment.

#### [config.json](https://github.com/silverfoxy/AnimateDead/blob/master/config.json)
This config file, defines the path to php.ini file, constants, include_path, server headers, and certain other configurations of the emulator. Things such as, the list of builtin functions that should return a symbolic value (e.g., mysql database APIs) or the list of variables that are symbolic based on request type (e.g., $_COOKIE, $_SESSION, $_POST, etc.)

### [Entry point - RaiseDead.php](https://github.com/silverfoxy/AnimateDead/blob/master/RaiseDead.php)
This is the entry point to AnimateDead. This file is invoked over CLI, and takes the path to access logs as input and starts emulating the PHP files from HTTP requests in the logs.

Usage: `php RaiseDead.php -l access.log -e extended_logs.log -r application/root/dir -u uri_prefix [-i ip_addr -v verbosity --reanimationpid pid]`

- `-l` or `-e` is used to defined  the path to log file (-l for normal and -e for extended logs)
- `-r` is path to the target web application files on the local file system.
- `-u` is the path prefix to the root of of target application as used within the log files. For instance, if our WordPress is hosted under /wp5.1 directory, we need to provide this information to the emulator. This way /wp5.1/index.php can be translated to the correct file on the local file system.
- `-i` can be used to only focus on entries of a certain IP address from the log files.
- `-v` defines the verbosity of the printed messages while running the code, I believe it ranges from 0-10.
- `--reanimationpid` can be used to replay the execution of one of the paths within an application in a single thread. This is usually used in combination with breakpoints to debug and explore a specific emulation.

We have two types of log files, normal access logs and extended logs.

##### Access logs 
These logs are the default log file produced by the Apache web server. They only include the HTTP verb (GET, POST, etc.), the URI and the response code. They do not include cookies and post parameters.
##### Extended logs
For some complex applications, emulation based on normal access logs means that we have to assume every POST parameter, COOKIE value and SESSION variable as Symbolic. This can quickly lead to a large number of paths that need to be explored. In order to make the analysis quicker, we introduced a notion of extended logs, which are produced by a small PHP module injected into the applications by PHP itself. These logs include the keys of defined POST, COOKIE, and SESSION variables. This way, if a key within these arrays were never defined, we can skip the exploration of those paths.

### [DistributedRaiseDead.php](https://github.com/silverfoxy/AnimateDead/blob/master/DistributedRaiseDead.php)
In order to explore multiple paths within an application efficiently, we make use of multiple worker processes and a message queue. This file prepares our emulator for this scheme.

#### [lib/AnimateDead/Utils.php](https://github.com/silverfoxy/AnimateDead/blob/master/lib/AnimateDead/Utils.php)
This file defines helper functions to parse and load config file.

> **Note**  
> **Reanimation**  
> This feature is an implementation of forced execution in AnimateDead. Forced execution, essentially drives the execution path towards a certain branch. For instance, whenever the emulator reaches a Symbolic if condition, the current worker will explore on branch, and add a new “Reanimation Job” to the queue so that another worker can explore the other branch of that symbolic if condition. In order to do this, each execution within the emulator will produce a log of the branches that it takes, the next worker can take this “Reanimation log”, and follow the execution to reach the same condition and then force the execution into the unexplored path. These logs are stored under “animate_dead/logs/reanimation_logs/[task_id]_reanimation_log.txt”.

#### [AnimateDeadWorker](https://github.com/silverfoxy/distributed_animate_dead/blob/master/php/client/AnimateDeadWorker.php)
Defines the APIs that consume new emulation tasks from the queue and produce new tasks to explore the new symbolic paths discovered in the application. This node consumes from **"WORKERS_QUEUE = executions"** queue.

#### [WraithOrchestrator(s) aka Master nodes](https://github.com/silverfoxy/distributed_animate_dead/blob/master/php/client/WraithOrchestrator.php)
Takes the reanimation jobs and termination information and assigns a priority to new jobs. This way, paths with higher priority will be explored first. Reanimation jobs and termination information is put onto the **"MANAGER_QUEUE = reanimations"** queue and new jobs are transferred to WORKERS_QUEUE.  
In the latest commit of this project, Master nodes are also run in a distributed fashion and use a Redis datastore to sync with each other. This helps add fresh reanimation tasks to the executions queue quicker.

#### Mock classes
This setup runs with RabbitMQ, inside docker. While it improves the performance compared to single threaded execution, it makes debugging tasks more challenging. In order to replay an emulation in a single thread without the extra details of the message queue, we defined mock classes that abstract away the queue related details. By running WraithOrchestrationNoMQ.php file inside the IDE, which itself uses AnimateDeadWorkerMock, we can set breakpoints inside the emulator code and debug the emulation as needed.