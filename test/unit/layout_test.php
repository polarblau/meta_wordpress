<?php
require_once(dirname(__FILE__) . '/../../lib/templates/lib/meta_wordpress/layout.class.php');

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

  function setUp() {
    $this->layout = new LayoutTestCase;
  }

  function testSetLayout() {
    $this->layout->set_layout('foo');
    $this->assertEqual($this->layout->layout, 'foo');
  }

  function testSetLayoutAgain() {
    $this->assertNotEqual($this->layout->layout, 'foo');
  }

  function testGetLayout() {}
}

?>
