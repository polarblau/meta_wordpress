module MetaWordpress
  module PHPHelpers

    # Wraps string into <?php ?> tags
    #
    # Examples (haml):
    #   = php "$foo = 'bar'"
    #   -->
    #   <?php $foo = 'bar' ?>
    #
    #   = php "if ($foo):" do
    #     %h1 Foo is true
    #   = endif
    #   -->
    #   <?php if ($foo): ?>
    #   <h1>Foo is true</h1>
    #   <?php endif ?>
    #
    def php(string, &block)
      output = if text.include?("\n")
        "<?php\n  %s\n?>" % string.rstrip.gsub("\n", "\n  ")
      else
        "<?php %s ?>" % string.strip
      end
      output = [output, capture_haml { yield }].join("\n") if block_given?
      output
    end

    # Wraps string into <?php ?> tags and prepends "echo"
    #
    # Example (haml):
    #   = php_e("$foo")
    #   -->
    #   <?php echo $foo ?>
    def php_e(string, &block)
      php "echo #{string}", &block
    end

  end
end
