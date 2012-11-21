require 'spec_helper'

class DummyContext; end

describe "Haml::Helpers" do
  subject { DummyContext.new.extend Haml::Helpers }

  context "#php" do

    it "should wrap text into PHP tags" do
      subject.php("foo").should == "<?php foo ?>"
    end

    it "should not add line breaks if text does not contain any" do
      subject.php("foo").should_not include("\n")
    end

    it "should wrap multiple lines properly" do
      subject.php("$foo = 'bar';\n$bar = 'foo';").
        should == "<?php\n  $foo = 'bar';\n  $bar = 'foo';\n?>"
    end

  end
end

describe "User helpers" do
  it "should be defined" do

  end
end
