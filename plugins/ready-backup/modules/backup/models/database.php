<?php


class databaseModelBup extends modelBup
{

    /** @var array */
    protected $config;
    private $use_mysqli = false;

    /**
     * Constructor
     */
    public function __construct()
    {
        if (function_exists('mysqli_connect')) {
            if (defined('WP_USE_EXT_MYSQL')) {
                $this->use_mysqli = !WP_USE_EXT_MYSQL;
            } elseif (version_compare(
                    phpversion(),
                    '5.5',
                    '>='
                ) || !function_exists('mysql_connect')
            ) {
                $this->use_mysqli = true;
            } elseif (false !== strpos($GLOBALS['wp_version'], '-')) {
                $this->use_mysqli = true;
            }
        }
    }


    /**
     * Create database backup
     * @param string $filename Path and file name of backup
     * @return bool TRUE if dump successfully created, FALSE otherwise.
     */
    public function create($filename)
    {
        /** @var wpdb $wpdb */
        global $wpdb;
        global $wp_db_version;
        global $wp_version;

        $database = array(
            sprintf('-- Created with %s %s', BUP_S_WP_PLUGIN_NAME, BUP_VERSION),
            '-- http://readyshoppingcart.com/product/wordpress-backup-and-restoration-plugin/' . PHP_EOL,
            sprintf('-- Do not change these values if you doesnt want broke the database during recovery:'),
            sprintf('-- @dbrev=%s;', $wp_db_version),        // database revision
            sprintf('-- @wpcrv=%s;', $wp_version),           // wordpress verison
            sprintf('-- @plgnv=%s;', BUP_VERSION) . PHP_EOL, // plugin version
        );

        $tables = $wpdb->get_results('SHOW TABLES', ARRAY_N);
        foreach($tables as $table) {
            $table['name'] = $table[0];

            // Drop table query
            $table['drop'] = 'DROP TABLE IF EXISTS `'.$table['name'].'`#endQuery' . PHP_EOL;

            // Create table query
            $createQuery = $wpdb->get_row('SHOW CREATE TABLE `'.$table['name'].'`', ARRAY_A);
            if(isset($createQuery['Create Table'])) {
                $table['create'] = $createQuery['Create Table'] . '#endQuery' . PHP_EOL;
            }

            // Get table columns
            $tableDataQuery = 'SELECT * FROM `'.$table['name'].'`';
            $tableColsQuery = 'SHOW COLUMNS FROM `'.$table['name'].'`';

            // Parse columns
            $tableCols = $this->parseColumns($wpdb->get_results($tableColsQuery, ARRAY_A));
            $tableData = $this->parseData($wpdb->get_results($tableDataQuery, ARRAY_N));
            foreach($tableData as $data) {
                $table['insert'] .= 'INSERT INTO `' . $table['name'] . '` (' . implode(', ', $tableCols) . ') VALUES (' . $data . ')' . '#endQuery' . PHP_EOL;
            }
            // Push results to stack
            $database[] = implode(PHP_EOL, array($table['drop'], $table['create'], $table['insert']));
        }

        if (file_put_contents($filename, implode(PHP_EOL, $database))) {
            return true;
        }

        return false;
    }

    /**
     * Restore database backup
     * @param string $filename Path and file name of database backup
     * @return bool TRUE if okay, FALSE otherwise.
     */
    public function restore($filename)
    {
        global $wpdb;

        if(file_exists($filename) === false) {
            $this->pushError(sprintf('Backup %s doesn\'t exists', basename($filename)));
            return false;
        }

        // Read SQL file
        $input = file_get_contents($filename);

        // Validate metadata
        $metadata = $this->parseMetadata($input);
        if($this->validateMetadata($metadata) === false) {
            return false;
        }

        // Is it old backup?
        if (preg_match('/(database|full)/ui', $filename)) {
            return $this->restoreFallback($filename);
        }

        // Parse queries
        $queries = $this->parseQueries($input);
        if($queries === null) {
            $this->pushError('Unable to parse queries from SQL file');
            return false;
        }

        // Run parsed queries
        if($this->runQueries($queries) === false) {
            $this->pushError($wpdb->last_error);
            return false;
        }

        return true;
    }

    public function restoreFallback($source)
    {
        /** @var wpdb $wpdb */
        global $wpdb;
        $ret = true;
        if ($handle = @fopen($source, "r")) {
            if ($this->clearFallback($source)) {
                while (($buffer = fgets($handle)) !== false) {
                    $wpdb->query($buffer);
                }

                if (!feof($handle)) {
                    $this->pushError(langBup::_("Error: unexpected fgets() fail"));
                }

                fclose($handle);
            } else {
                $this->pushError(langBup::_('Unable to clear the database before restoring'));
                $ret = false;
            }
        } else {
            $this->pushError(langBup::_(sprintf('File not found: %s', $source)));
            $ret = false;
        }

        return $ret;
    }

    public function clearFallback($source)
    {
        /** @var wpdb $wpdb */
        global $wpdb;
        $ret = true;
        if ($handle = @fopen($source, "r")) {
            $i = 0;
            while (($buffer = fgets($handle)) !== false) {
                $i++;
                if ($i <= 4) continue;

                preg_match_all('~CREATE TABLE `(.*)` \( ~', $buffer, $out);
                if ($out[1][0]) {
                    $wpdb->query("DROP TABLE {$out[1][0]};");
                } else
                    break;
            }
        } else {
            $this->pushError(langBup::_('Can not find file'.$source));
            $ret = false;
        }
        return $ret;
    }

    /**
     * Validate metadata of SQL file and stop restore if its invalid
     * @param  array $metdata
     * @return boolean
     */
    protected function validateMetadata($metdata) {
        global $wp_db_version;
        global $wp_version;

        $config = $this->getConfig();
        // If force update enabled then we does not have any reasons to validate metadata
        if($config['force_update'] === true) {
            return true;
        }

        if($metdata['dbrev'] != $wp_db_version) {
            $this->pushError(
                langBup::_('Revision of backup and your database do not match. '
                    . 'You must enable the Force Update options to update '
                    . '(at one\'s own risk)')
            );
            return false;
        }

        if($metdata['wpcrv'] != $wp_version) {
            $this->pushError(
                langBup::_('This backup was made on another version of WordPress. '
                    . 'You must enable the Force Update options to update '
                    . '(at one\'s own risk)')
            );
            return false;
        }

        if($metdata['plgnv'] != BUP_VERSION) {
            $this->pushError(
                langBup::_('Backup was created with a different version of the plugin. '
                    . 'You must enable the Force Update options to update '
                    . '(at one\'s own risk)')
            );
            return false;
        }

        return true;
    }

    /**
     * Run parsed queries from SQL file
     * @global \wpdb   $wpdb
     * @param  array   $queries
     * @return boolean
     */
    protected function runQueries($queries = array()) {
        /** @var wpdb $wpdb */
        global $wpdb;

        $config = $this->getConfig();
        $transaction = $this->getTransactionSupport();

        if(empty($queries) OR $queries === null) {
            return false;
        }

        // Start transaction if safe update enabled or set error if transaction is unsupported
        if($config['safe_update'] === true) {
            if($transaction === true) {
                $this->query('SET AUTOCOMMIT=0');
                $this->query('START TRANSACTION');
            }
            else {
                $this->pushError(langBup::_('Your MySQL server does not support transactions, "safe update" unavailable'));
                return false;
            }
        }

        $this->query('SET FOREIGN_KEY_CHECKS=0');


        foreach($queries as $query) {
            if($wpdb->query($query) === false) {
                // Rollback transaction if safe update enabled
                if($config['safe_update'] === true && $transaction === true) {
                    $this->query('ROLLBACK');
                }

                $this->query('SET FOREIGN_KEY_CHECKS=1');
                return false;
            }
        }

        // Commit transaction if safe update enabled
        if($config['safe_update'] === true && $transaction === true) {
            $this->query('COMMIT');
        }

        $this->query('SET FOREIGN_KEY_CHECKS=1', $wpdb->dbh);

        return true;
    }

    /**
     * Check for MySQL server verion, db handler access and other
     * @global wpdb $wpdb
     * @return boolean
     */
    public function getTransactionSupport() {
        /** @var wpdb $wpdb */
        global $wpdb;

        if (!$this->use_mysqli) {

            if (!function_exists('mysql_query') && function_exists(
                    'mysql_get_server_info'
                )
            ) {
                return false;
            }

            // Can we get access to the database handler?
            if (is_resource($wpdb->dbh) === false) {
                return false;
            }

            // Is it 5.x.x version?
            $serverInfo = mysql_get_server_info($wpdb->dbh);
            if (substr($serverInfo, 0, 1) != 5) {
                return false;
            }

            return true;
        }

        if (!function_exists('mysqli_get_server_info')) {
            return false;
        }

        $serverInfo = mysqli_get_server_info($wpdb->dbh);
        if (substr($serverInfo, 0, 1) != 5) {
            return false;
        }

        return true;
    }

    /**
     * Parse matrix of columns to the one dimensional array
     * @param  array $columns
     * @return array
     */
    protected function parseColumns($columns) {
        $result = array();

        foreach($columns as $column) {
            $result[] = $column['Field'];
        }

        return $result;
    }

    /**
     * Parse columns data from matrix to the one dimensional array
     * @param  array $data
     * @return array
     */
    protected function parseData($data) {
        $result = array();

        foreach($data as $column) {
            $values = array_map(array($this, 'addQuotes'), array_values($column));

            $result[] = implode(', ', $values);
        }

        return $result;
    }

    /**
     * Parse queries from sql file
     * @param  string $input
     * @return null|array
     */
    protected function parseQueries($input) {
        $queries = array();
        $permitted = 'CREATE|INSERT|DROP';

        // We parse only permitted queries from file
        preg_match_all('/(('.$permitted.')(.*?))#endQuery/su', $input, $queries);

        if(isset($queries[1]) && !empty($queries[1])) {
            return $queries[1];
        }

        return null;
    }

    /**
     * Parse metadata from SQL file
     * @param  string $input
     * @return null|array
     */
    protected function parseMetadata($input) {
        $metadata = array();
        preg_match_all('/--\s*@(.*);/', $input, $metadata);

        if(isset($metadata[1]) && !empty($metadata[1])) {
            $variables = array();
            // Create an array with key => val from strings with key=val
            foreach($metadata[1] as $variableType) {
                $e = explode('=', $variableType);
                $variables[trim($e[0])] = trim($e[1]);
            }
            return $variables;
        }

        return null;
    }

    /**
     * Add quotes to string values
     * @param  string $value
     * @return string|integer
     */
    public function addQuotes($value) {
        /** @var wpdb $wpdb */
        global $wpdb;

        if(is_numeric($value)) {
            return $value;
        }
        $value = "'". $wpdb->_real_escape($value) . "'";

        return $value;
    }

    /**
     * Set an array of configurations
     * @param array $config
     * @return databaseModelBup
     */
    public function setConfig(array $config)
    {
        $this->config = $config;
        return $this;
    }

    /**
     * Returns an array of configurations
     * @return array
     */
    public function getConfig()
    {
        return $this->config;
    }

    /**
     * Executes the query
     *
     * @param string $query
     */
    public function query($query)
    {
        if (!$this->use_mysqli) {

            $this->mysqlQuery($query);

        } else {

            $this->mysqliQuery($query);
        }
    }

    protected function mysqlQuery($query)
    {
        global $wpdb;

        if (is_resource($wpdb->dbh) && function_exists('mysql_query')) {
            @mysql_query($query, $wpdb->dbh);

            return;
        }

        wp_die('Fatal error: Wordpress uses mysql, but extension does not exists.');
    }

    protected function mysqliQuery($query)
    {
        global $wpdb;

        if (function_exists('mysqli_query')) {
            @mysqli_query($wpdb->dbh, $query);

            return;
        }

        wp_die('Fatal error: Wordpress uses mysqli, but extension does not exists.');
    }
}