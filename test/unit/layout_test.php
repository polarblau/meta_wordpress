<?php
require_once(dirname(__FILE__) . '/../../lib/templates/lib/meta_wordpress/layout.class.php');

class TestOfLayout extends UnitTestCase {

  function __construct() {
    parent::__construct('Layout class tests');
  }

  function setUp() {
    $this->layout = Layout::Instance();
  }

  function testSetLayout() {
    $this->layout->set_layout('foo');
    $this->assertEqual($this->layout->layout, 'foo');
  }
}

?>
