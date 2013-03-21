<?php

/**
 * Layout
 *
 * Implements layout wrappers, partials and fragments.
 *
 * @package    MetaWordpress
 * @author     Florian Plank <florian@polarblau.com>
 * @copyright  2012 Florian Plank
 * @license    http://mit-license.org/ MIT License
 * @version    0.1
 * @since      Version 0.1
 */
abstract class LayoutAbstract {
  //private static $instance;
  protected static $instance = null;

  private $fragments              = array();
  private $fragments_placeholders = array();
  public $layout                  = null;
  private $template_content       = null;
  private $settings               = array(
    'views_path'          => '',
    'partials_path'       => 'partials',
    'layouts_path'        => 'layouts',
    'default_layout_name' => 'default'
  );

  /**
   * Retrieves fragment stored using an identfier or
   * template contents and echos them into view
   *
   * @access public
   * @param {string} name Fragment identifier
   */
  public function yield($name = null) {
    if (isset($name) && !empty($name)) {
      if (array_key_exists($name, $this->fragments)) {
        echo $this->fragments[$name];
      } else {
        echo $this->register_fragment_placeholder($name);
      }

    } else {
      echo $this->template_content;
    }
  }

  /**
   * Stores a fragment using an identifier.
   * Retrieve the fragment elsewhere by passing the identifier to yield()
   *
   * @access public
   * @param string name Fragment identifier
   * @param function method Closure, returns content
   */
  public function content_for($name, $method) {
    if (!array_key_exists($name, $this->fragments)) {
      ob_start();
      $method();
      $fragment = ob_get_contents();
      ob_end_clean();
      $this->fragments[$name] = $fragment;
    }
  }

  /**
   * Loads and renders a partial file defined by name.
   * Defines local variables (vars) in partial scope.
   *
   * File naming conventions for partials:
   *
   *   render_partial('foo')          -> /partials/_foo.php
   *   render_partial('foo/bar/bart') -> /partials/foo/bar/_bat.php
   *
   * Local variables:
   *
   *   render_partial('foo', array('bar' => 'bat'))
   *   -> makes a local variable `$bar` with value 'bat' available
   *
   * @access public
   * @param string name Partial file name
   * @param array vars Assoc. array of local variables
   * @param boolean echo Function will return partial content when set to false
   * @return string partials content if `echo` is set to `false`
   */
  public function render_partial($name, $vars = array(), $echo = true) {

    $partial_path = $this->get_partial_path($name);
    $output = $this->capture_eval(file_get_contents($partial_path), $vars);

    if ($echo === false) return $output;
    echo $output;
  }

  /**
   * The method used to hook into Wordpress' template_include filter
   *
   * @access public
   * @param string template
   * @return string or null
   */
  public function render($template) {
    if (file_exists($template)) {
      $template_content = file_get_contents($template);
      $template_content = $this->capture_eval($template_content);

      $this->template_content = $template_content;
      // template content needs to be set before layout is evaluated
      // since yield() will expect it to be set

      $output = $this->capture_eval(file_get_contents($this->get_layout_path()));
      $output = $this->replace_fragments_placeholders($output);

      echo $output;
      return null;
    }

    // Invalid template supplied, let Wordpress deal with this
    return $template;
  }

  /**
   * Setter, layout
   * By default a layout in `/layouts/default.php` is expected
   *
   * @access public
   * @param string layout Layout file name
   */
  public function set_layout($name) {
    $this->layout = $name;
  }

  /**
   * Getter, layout
   *
   * @access public
   * @return string name Layout file name
   */
  public function get_layout() {
    return $this->layout ? $this->layout : $this->get_setting('default_layout_name');
  }

  /**
   * Override default settings
   *
   * @access public
   * @param array settings
   */
  public function set_settings($settings) {
    $this->settings = array_merge($this->settings, $settings);
  }

  /**
   * Retrieve setting by name
   *
   * @access public
   * @param string name
   * @return mixed setting
   */
  public function get_setting($name) {
    return $this->settings[$name];
  }

  /**
   * Get layout path
   * Throws error if layout file doesn't exist
   *
   * @access private
   * @return string name Layout file name
   */
  private function get_layout_path() {
    $layout       = $this->get_layout();
    $views_path   = $this->get_setting('views_path');
    $layouts_path = $this->get_setting('layouts_path');
    $layout_path  = implode('/', array($views_path, $layouts_path, "$layout.php"));

    if (!file_exists($layout_path)) {
      $this->throw_error("The specified layout could not be found: <em>$layout_path</em>");
    }

    return $layout_path;
  }

  /**
   * Get partial path by name
   * Throws error if partial file doesn't exist
   *
   * @access private
   * @return string name Partial file name
   */
  private function get_partial_path($name) {
    $path          = explode('/', $name);
    $file_name     = array_pop($path);
    $views_path    = $this->get_setting('views_path');
    $partials_path = $this->get_setting('partials_path');

    if (!empty($path)) {
      $partials_path = implode('/', array($partials_path, implode('/', $path)));
    }

    $partial_path  = implode('/', array($views_path, $partials_path, "_{$file_name}.php"));

    if (!file_exists($partial_path)) {
      $this->throw_error("The specified partial could not be found: <em>$partial_path</em>");
    }

    return $partial_path;
  }

  /**
   * Replace fragment placeholders in template_content
   *
   * @access private
   * @param string template_content
   * @return string template_content with placeholders replaced
   * @since Version 0.1
   */
  private function replace_fragments_placeholders($template_content) {
    $search  = array();
    $replace = array();

    foreach ($this->fragments_placeholders as $name => $placeholder) {
      $search[] = $placeholder;
      if (array_key_exists($name, $this->fragments)) {
        $replace[] = $this->fragments[$name];
      } else {
        $replace[] = '';
      }
    }
    return str_replace($search, $replace, $template_content);
  }

  /**
   * Evaluate string and read buffer into return to intercept
   * regular rendering.
   *
   * @access private
   * @param string string String to evaluate
   * @param array vars Local variables
   * @return string
   * @since Version 0.1
   */
  private function capture_eval($string, $vars = array()) {
    // extract local variables
    extract($vars);
    ob_start();

    // evaluate string and read-out buffer
    eval('?>' . $string);

    $contents = ob_get_contents();
    ob_end_clean();

    return $contents;
  }

  /**
   * Generate a fragment placeholder and store it.
   *
   * @access private
   * @param string name Fragment name
   * @return string placeholder
   * @since Version 0.1
   */
  private function register_fragment_placeholder($name) {
    $placeholder = "%content_for:$name%";
    $this->fragments_placeholders[$name] = $placeholder;
    return $placeholder;
  }

  /**
   * Throws error with message and kills output.
   *
   * @access private
   * @param string string Error message
   * @param {constant} type Error type, by default E_USER_ERROR
   * @since Version 0.1
   */
  private function throw_error($message, $type = E_USER_ERROR) {
    trigger_error($message, $type);
    die();
  }

}


class Layout extends LayoutAbstract {
  private function __construct() {}
  private function __clone() {}

  public static function Instance() {
    if (!Layout::$instance instanceof self) {
      Layout::$instance = new self();
    }
    return Layout::$instance;
  }
}

class LayoutTestCase extends LayoutAbstract {
  public function __construct() {}
}

?>
