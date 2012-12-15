<?php

/* 
 * Error display
 *
 * Print all errors and warnings in development.
 * Remove or edit this at will!
 */
$development_hosts = array('localhost', '127.0.0.1');

if (in_array($_SERVER['HTTP_HOST'], $development_hosts)) {
  error_reporting(E_ALL);
  ini_set('display_errors', '1');
}

/* 
 * Don't remove this line!
 * This include will provide us with the necessary functionality
 * to render templates the HAML way.
 */
require_once 'lib/meta_wordpress.php';


/*
 * Add your own functions here ...
 *
 */


?>
