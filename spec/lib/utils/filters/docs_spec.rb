require 'spec_helper'

describe Utils::Filters::Docs do

  it "should render single line docs" do
    haml(":docs\n  Foobar").
      should == "<?php\n/**\n * Foobar\n */\n?>\n"
  end

  it "should render multiple lines of docs" do
    haml(":docs\n  Foobar\n  Barfoo").
      should == "<?php\n/**\n * Foobar\n * Barfoo\n */\n?>\n"
  end

end
