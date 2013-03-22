<?php

require_once dirname(__FILE__) . '/layout.class.php';

// Global aliases to be used in views:
function layout_settings($settings) {
  return Layout::Instance()->set_settings($settings);
}

function use_layout($name) {
  return Layout::Instance()->set_layout($name);
}

function render_partial($name, $variables = array(), $echo = true) {
  return Layout::Instance()->render_partial($name, $variables, $echo);
}

function content_for($name, $method) {
  return Layout::Instance()->content_for($name, $method);
}

function yield($name = null) {
  return Layout::Instance()->yield($name);
}

function meta_wordpress_template($template) {
  return Layout::Instance()->render($template);
}
add_filter('template_include', 'meta_wordpress_template');

// Settings:
layout_settings(array(
  'views_path' => TEMPLATEPATH
));

?>
