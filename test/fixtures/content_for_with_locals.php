<?php yield('bar') ?>
<?php 
  $foobar = 'locals!';
  content_for('bar', function() use($foobar) { ?>Content set with <?php echo $foobar ?><?php }) ?>
