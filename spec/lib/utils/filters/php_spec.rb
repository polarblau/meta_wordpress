require 'spec_helper'

describe Utils::Filters::PHP do

  it "should render single line of PHP code" do
    haml(":php\n  $foo = 'bar';").
      should == "<?php\n  $foo = 'bar';\n?>\n"
  end

  it "should render multiple lines of PHP code" do
    haml(":php\n  $foo = 'bar';\n  echo $foo;").
      should == "<?php\n  $foo = 'bar';\n  echo $foo;\n?>\n"
  end

end
