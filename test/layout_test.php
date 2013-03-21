<?php
require_once('simpletest/autorun.php');
require_once('lib/templates/lib/meta_wordpress/layout.class.php');

class TestOfLayout extends UnitTestCase {
  
  function setUp() {
    $this->layout = Layout::Instance();
  }
  
  function testSetLayout() {
    $this->layout->set_layout('foo');
    $this->assertEqual($this->layout->layout, 'foo');
  }
}
?>
