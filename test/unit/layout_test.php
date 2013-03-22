<?php

function add_filter($a, $b) {}

require_once(dirname(__FILE__) . '/../../lib/templates/lib/meta_wordpress.php');

class TestOfSingletonLayout extends UnitTestCase {
  function __construct() {
    parent::__construct('Layout singleton tests');
  }

  function testStatePersists() {
    $layout_1 = Layout::Instance();
    $this->assertNotEqual($layout_1->layout, 'foo');

    $layout_1->set_layout('foo');
    $this->assertEqual($layout_1->layout, 'foo');

    $layout_2 = Layout::Instance();
    $this->assertEqual($layout_2->layout, 'foo');
  }
}

class TestOfLayout extends UnitTestCase {
  function __construct() {
    parent::__construct('Layout class tests');
  }

  private $defaults = array(
    'views_path'          => '',
    'partials_path'       => 'partials',
    'layouts_path'        => 'layouts',
    'default_layout_name' => 'default'
  );


  function setUp() {
    $this->layout = new LayoutTestCase;
  }

  function capture($callback) {
    ob_start();
    $callback();
    $contents = ob_get_contents();
    ob_end_clean();
    return $contents;
  }

  # set_layout

  function testSetLayout() {
    $this->layout->set_layout('foo');
    $this->assertEqual($this->layout->layout, 'foo');
  }

  # get_layout

  function testGetLayout() {
    $this->assertEqual($this->layout->get_layout(), 'default');

    $this->layout->set_layout('foo');
    $this->assertEqual($this->layout->get_layout(), 'foo');
    $this->assertEqual($this->layout->get_layout(), $this->layout->layout);
  }

  # get_setting

  function testGetSetting() {
    foreach ($this->defaults as $key => $value) {
      $this->assertEqual($this->layout->get_setting($key), $value);
    }

    $this->layout->set_settings(array('views_path' => 'foo'));
    $this->assertEqual($this->layout->get_setting('views_path'), 'foo');
  }

  # set_settings

  function testSetSettings() {
    $this->layout->set_settings(array('views_path' => 'foo', 'partials_path' => 'bar'));
    $this->assertEqual($this->layout->get_setting('views_path'), 'foo');
    $this->assertEqual($this->layout->get_setting('partials_path'), 'bar');
  }

  # yield

  function makeLayout() {
    $layout = Layout::Instance();
    $layout->set_settings($this->defaults);
    $layout->set_layout('default');
    $layout->set_settings(array(
      'views_path' => dirname(__FILE__) . '/../fixtures'
    ));
    return $layout;
  }

  function testYield() {
    $layout = $this->makeLayout();
    $output = $this->capture(function() use($layout) {
      $layout->render(dirname(__FILE__) . '/../fixtures/yield.php');
    });
    $this->assertEqual($output, 'Yield!');
  }

  function testYieldToFragment() {
    $layout = $this->makeLayout();
    $output = $this->capture(function() use($layout) {
      $layout->render(dirname(__FILE__) . '/../fixtures/yield_to_fragment.php');
    });
    $this->assertEqual($output, 'Fragment yielded to!');
  }

  # content_for

  function testContentFor() {
    $layout = $this->makeLayout();
    $output = $this->capture(function() use($layout) {
      $layout->render(dirname(__FILE__) . '/../fixtures/content_for.php');
    });
    $this->assertEqual($output, 'Content set!');
  }

  function testContentForWithLocals() {
    $layout = $this->makeLayout();
    $output = $this->capture(function() use($layout) {
      $layout->render(dirname(__FILE__) . '/../fixtures/content_for_with_locals.php');
    });
    $this->assertEqual($output, 'Content set with locals!');
  }

  # render_partial

  function testRenderPartial() {
    $layout = $this->makeLayout();
    $output = $this->capture(function() use($layout) {
      $layout->render(dirname(__FILE__) . '/../fixtures/render_partial.php');
    });
    $this->assertEqual($output, 'Simple partial!');
  }

  function testRenderPartialWithLocals() {
    $layout = $this->makeLayout();
    $output = $this->capture(function() use($layout) {
      $layout->render(dirname(__FILE__) . '/../fixtures/render_partial_with_locals.php');
    });
    $this->assertEqual($output, 'Partial! This time with locals!');
  }

}
?>
