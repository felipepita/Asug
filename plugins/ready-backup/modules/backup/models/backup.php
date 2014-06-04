<?php

/**
 * Class backupModelBup
 * Filesystem & Database facade
 * Database and filesystem models need to implement some interface, but i think
 * in here it is not critical
 */
class backupModelBup extends modelBup {

    /**
     * @var filesystemModelBup
     */
    protected $filesystem;

    /**
     * @var databaseModelBup
     */
    protected $database;

    /**
     * @var array
     */
    protected $config;

    /**
     * @var int
     */
    public $id;

    /**
     * Constructor
     */
    public function __construct()
    {
        /** @var backupBup $backup */
        $backup = frameBup::_()->getModule('backup');
        /** @var backupControllerBup $controller */
        $controller = $backup->getController();

        if ($this->filesystem === null) {
            $this->filesystem = $controller->getModel('filesystem');
        }

        if ($this->database === null) {
            $this->database = $controller->getModel('database');
        }

        /* Set configuration array in the database model. For backward compatibility */
        $this->database->setConfig($this->getConfig());
    }

    /**
     * Generate filename with specified extensions
     * @param array $extensions An array of required extensions
     * @return array An associative array with filename
     */
    public function generateFilename(array $extensions)
    {
        $pattern = 'backup_{datetime}_id{id}.{extension}';
        $search = array('{datetime}', '{id}', '{extension}');
        $replace = array(date('Y_m_d-H_i_s'), $this->getId());
        $warehouse = $this->getConfig('warehouse');
        $names = array();

        foreach ($extensions as $extension) {
            $replace = array_merge($replace, array('{extension}' => $extension));
            $names[$extension] = rtrim($warehouse, '/') . '/' . str_replace($search, $replace, $pattern);
        }

        return $names;
    }

    /**
     * Get next identifier
     * @return int|mixed
     */
    public function getId()
    {
        if ($this->id === null) {
            $files = scandir($this->getConfig('warehouse'));

            $matches = array();
            $results = array();

            foreach($files as $file) {
                if(preg_match('/id([\d]+)/', $file, $matches)) {
                    $results[] = $matches[1];
                }
            }

            if(!empty($results)) {
                $this->id = max($results) + 1;
            }
            else {
                $this->id = 1;
            }
        }

        return $this->id;
    }

    /**
     * Returns an array of old backups
     * @return array
     */
    public function getOldBackupsList() {
        $config  = $this->getConfig();
        $pattern = '/(backup_([0-9_-]*)-(database|full)_id([\d]+))\.(zip|sql)/ui';
        $backups = array();
        $matches = array();

        $files = @scandir(realpath($config['warehouse']));

        if (!is_array($files) || empty($files)) {
            return array();
        }

        foreach ($files as $node) {
            if (preg_match($pattern, $node, $matches)) {
                list($name, $rawname, $datetime, $type, $id, $ext) = $matches;

                $e = explode('-', $datetime);
                $date = str_replace('_', '-', $e[0]);
                $time = str_replace('_', ':', $e[1]);

                $backups[] = array(
                    'id' => $id,
                    'name' => $name,
                    'raw'  => $rawname,
                    'ext'  => $ext,
                    'type' => $type,
                    'date' => $date,
                    'time' => $time,
                );
            }
        }

        return $backups;
    }

    /**
     * Return all founded backups
     * @return null|array
     */
    public function getBackupsList() {
        $config  = $this->getConfig();
        $pattern = '/(backup_([0-9_-]*)_id([0-9]+))\.(zip|sql)/ui';
        $backups = array();

        $dir = @scandir(realpath($config['warehouse']));

        if (!is_array($dir) || empty($dir)) {
            return array();
        }

        foreach ($dir as $file) {
            $matches = array();

            if (preg_match($pattern, $file, $matches)) {
                list ($name, $rawname, $date, $id, $extension) = $matches;

                $e = explode('-', $date);
                $datetime['date'] = str_replace('_', '-', $e[0]);
                $datetime['time'] = str_replace('_', ':', $e[1]);

                // Generate backups array by ID
                $backups[$id][strtolower($extension)] = array(
                    'id'   => $id,
                    'name' => $name,
                    'raw'  => $rawname,
                    'ext'  => $extension,
                    'date' => $datetime['date'],
                    'time' => $datetime['time'],
                );
            }
        }
        krsort($backups);
        return $backups;
    }

    /**
     * Remove backup
     * @param string $filename File name of the backup
     * @return bool TRUE if file exists and successfully removed, FALSE otherwise.
     */
    public function remove($filename)
    {
        if (file_exists($file = $this->getConfig('warehouse') . $filename)) {
            if (unlink($file)) {
                return true;
            }

            return false;
        }

        return false;
    }

    /**
     * Restore from backup
     * @param string $filename
     * @return bool
     */
    public function restore($filename)
    {
        if (file_exists($file = $this->getConfig('warehouse') . $filename)) {

            $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));

            if ($ext === 'sql') {
                return $this->database->restore($file);
            } elseif ($ext === 'zip') {
                return $this->filesystem->restore($file);
            }

            return false;
        }

        return false;
    }

    /**
     * Is database backup required?
     * @return bool TRUE if required, FALSE otherwise.
     */
    public function isDatabaseRequired()
    {
        return $this->isSomethingRequired(array(
            'full_backup', 'database'
        ));
    }

    /**
     * Is filesystem backup required?
     * @return bool TRUE if require, FALSE otherwise.
     */
    public function isFilesystemRequired()
    {
        return $this->isSomethingRequired(array(
            'full_backup', 'any_dir', 'plugins_dir', 'themes_dir', 'uploads_dir'
        ));
    }

    /**
     * Returns an array of excluded directories
     * @return array
     */
    public function getExcludedDirectories()
    {
        $directories = $this->getConfig('exclude');

        if (empty($directories)) {
            return array();
        }

        return $this->filesystem->splitExcludedDirectories($directories);
    }

    /**
     * Set excluded directories
     * @param string|array $directories Comma-separated string or an array of directories
     * @param bool $replace If TRUE then specified directories will replace current, FALSE - append to the end.
     */
    public function setExcludedDirectories($directories, $replace = false)
    {
        /** @var optionsBup $options */
        $options = frameBup::_()->getModule('options');

        if (is_array($directories)) {
            $directories = implode(',', $directories);
        }

        if (!$replace) {
            $exclude = $this->getConfig('exclude');

            $directories = implode(',', array(rtrim($exclude, ','), $directories));
        }

        $this->config['exclude'] = $directories;
    }

    /**
     * Is specified directory is in excluded list?
     * @param string $directory Name of the directory
     * @return bool TRUE if it in the list, FALSE otherwise.
     */
    public function isExcluded($directory)
    {
        $excluded = $this->getConfig('exclude');

        foreach ($this->filesystem->splitExcludedDirectories($excluded) as $excludedDirectory) {
            if (strtolower($excludedDirectory) === strtolower($directory)) {
                return true;
            }
        }

        return false;
    }

    /**
     * @param null|string $directory
     * @return array|bool
     */
    public function getFilesList($directory = null)
    {
        if ($directory === null) {
            $directory = realpath(ABSPATH);
        }

        if (!$this->isExcluded('upready')) {
            $this->setExcludedDirectories(array('upready', 'ready-backup', 'ready-backup-pro'));
        }

        /* Setup excluded folders */
        $excluded = array();

        $options = $this->getConfig(array('themes_dir', 'plugins_dir', 'uploads_dir'));
        foreach ($options as $key => $value) {
            if (!$value) {
                $excluded[] = str_replace('_dir', '', $key);
            }
        }

        if (false === $this->getConfig('any_dir')) {
            foreach (glob(realpath(WP_CONTENT_DIR) . '/*') as $node) {
                if (is_dir($node) && !in_array($node, array('plugins', 'themes', 'uploads'))) {
                    $excluded[] = basename($node);
                }
            }
        }

        $this->setExcludedDirectories($excluded);

        return $this->filesystem->getFilesList($directory, $this->getExcludedDirectories());
    }

    /**
     * Get the database model
     * @return databaseModelBup
     */
    public function getDatabase()
    {
        return $this->database;
    }

    /**
     * Get the filesystem model
     * @return filesystemModelBup
     */
    public function getFilesystem()
    {
        return $this->filesystem;
    }

    public function getDestinationHandlers() {
        $handlers = array();
        $handlers = dispatcherBup::applyFilters('adminBackupUpload', $handlers);

        return $handlers;
    }

    /**
     * Get backup configurations
     * @param string|array $item The keys to get from config
     * @return mixed
     */
    public function getConfig($item = null)
    {
        if ((!is_array($this->config) || empty($this->config)) || count($this->config) < 1) {

            /** @var optionsBup $options */
            $options = frameBup::getInstance()->getModule('options');

            $this->config = array(
                'full_backup'   => (bool)$options->get('full'),
                'plugins_dir'   => (bool)$options->get('plugins'),
                'themes_dir'    => (bool)$options->get('themes'),
                'uploads_dir'   => (bool)$options->get('uploads'),
                'database'      => (bool)$options->get('database'),
                'any_dir'       => (bool)$options->get('any_directories'),
                'exclude'       => $options->get('exclude'),
                'warehouse'     => realpath(ABSPATH . $options->get('warehouse')) . DIRECTORY_SEPARATOR,
                'dest'          => $options->get('glb_dest'),
                // Since 2.0
                'force_update'  => (bool)$options->get('force_update'),
                'safe_update'   => (bool)$options->get('safe_update'),
                'replace_newer' => (bool)$options->get('replace_newer'),
            );
        }

        if ($item === null) {
            return $this->config;
        }

        if (is_string($item)) {
            return (isset($this->config[$item]) ? $this->config[$item] : null);
        }

        if (is_array($item)) {
            $config = array();

            foreach ($item as $key) {
                if (isset($this->config[$key])) {
                    $config[$key] = $this->config[$key];
                }
            }

            return $config;
        }

        return null;
    }

    /**
     * Is some backup type is required or not
     * @param array $keys An array of keys to check
     * @return bool TRUE if one of the keys is TRUE, FALSE otherwise.
     */
    protected function isSomethingRequired(array $keys)
    {
        foreach ($keys as $key) {
            $value = $this->getConfig($key);
            if (null !== $value) {
                if ((bool)$value) {
                    return true;
                }
            }
        }

        return false;
    }
} 