<?php 
/**
 * Layout helpers to be used in Wordpress template files.
 *
 * @package    PackageName
 * @author     Florian Plank <florian@polarblau.com>
 * @copyright  2012 Florian Plank
 * @license    http://mit-license.org/ MIT License
 * @version    0.1
 * @since      Version 0.1
 */
 
/**
 * Intercepts template includes to allow for a unified layout wrapper
 * as well as partial rendering
 *
 * @access public
 * @param string
 * @return string
 * @since Version 0.1
 */
function meta_wordpress_template($template) {
  global $template_output, $template_layout;
  global $posts, $post, $wp_did_header, $wp_did_template_redirect, $wp_query, 
         $wp_rewrite, $wpdb, $wp_version, $wp, $id, $comment, $user_ID;
  
  if (file_exists($template)) {
    $template_output = capture_eval(file_get_contents($template));
    
    if ($template_layout == '') {
      $template_layout = TEMPLATEPATH . "/layouts/default.php";
    }
    
    if (!file_exists($template_layout)) {
      trigger_error("The specified layout could not be found: <em>$template_layout</em>", E_USER_NOTICE);
      die();
    }
    
    $template_vars   = array('template_output' => $template_output);
    echo capture_eval(file_get_contents($template_layout), $template_vars);
    return null;
  }

  return $template;
}
add_filter('template_include', 'meta_wordpress_template');


/**
 * Evaluate string and read buffer into return to intercept
 * regular rendering.
 *
 * @access public
 * @param string
 * @param array
 * @return string
 * @since Version 0.1
 */
function capture_eval($string, $vars = array()) {
  extract($vars);
  ob_start();
  eval('?>' . $string);
  $contents = ob_get_contents();
  ob_end_clean();
  return $contents;
}

/**
 * Yield for content within layout
 *
 * @access public
 * @since Version 0.1
 */
function yield() {
  global $template_output;

  if ($template_output == '') {
    trigger_error("Empty template supplied to <tt>yield</tt>", E_USER_NOTICE);
    die();
  }

  echo $template_output;
}

/**
 * Define which layout file should be used
 * Expects this file to be stored in /layouts/$name.php
 * Call this at the top of your template file.
 *
 * @access public
 * @param string
 * @since Version 0.1
 */
function use_layout($name) {
  global $template_layout;

  $layout = TEMPLATEPATH . "/layouts/$name.php";

  if(!file_exists($layout)) {
    trigger_error("The specified layout could not be found: <em>$layout</em>", E_USER_ERROR);
    die();
  }

  $template_layout = $layout;
}

/**
 * Renders or returns partial
 *
 * @access public
 * @param string
 * @param boolean
 * @return string or nothing
 * @since Version 0.1
 */
function render_partial($name, $variables = array(), $return = false) {

  $partial_template = TEMPLATEPATH . "/partials/_$name.php";

  if (!file_exists($partial_template)) {
    trigger_error("The specified partial could not be found: <em>$partial_template</em>", E_USER_ERROR);
    die();
  }

  extract($variables);
  ob_start();
  $partial_output = eval('?>'.file_get_contents($partial_template));
  $output = ob_get_clean();

  if ($return) {
    return $partial_output;
  }

  echo $output;
}

?>
