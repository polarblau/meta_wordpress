require 'spec_helper'

class DummyContext; end

describe "Haml::Helpers" do
  let(:view) { DummyContext.new.extend Haml::Helpers }

  describe "#php" do
    context "simple string" do
      subject { view.php("foo") }

      it { should == "<?php foo ?>" }
      it { should_not include("\n") }
    end

    context "multiple lines" do
      subject { view.php("$foo = 'bar';\n$bar = 'foo';") }
      it { should == "<?php\n  $foo = 'bar';\n  $bar = 'foo';\n?>" }
    end

    context "with block" do
      subject { haml("= php 'if ($foo):' do\n  %h1= php_e '$foo'\n= php 'endif'") }
      it { should == "<?php if ($foo): ?>\n<h1><?php echo $foo ?></h1>\n<?php endif ?>\n" }
    end
  end

  describe "#php_e" do
    subject { view.php_e("$foo") }

    it { should == "<?php echo $foo ?>" }
  end

  describe "User helpers" do
    it "should be defined"
  end

  # we'll be testing this private method as well,
  # as it is essential to other parts and might even
  # become public at some point
  describe "#convert_php_arguments" do
    it "should wrap string" do
      view.send(:convert_php_arguments, "foo").should == "'foo'"
    end

    it "should not wrap PHP vars" do
      view.send(:convert_php_arguments, "$foo").should == "$foo"
    end

    it "should not wrap Numbers" do
      view.send(:convert_php_arguments, 123).should == 123
    end

    it "should convert hashes to assoc. arrays" do
      view.send(:convert_php_arguments, :foo => "bar").
        should == "array('foo' => 'bar')"
    end

    it "should convert nested hashes to nested assoc. arrays" do
      view.send(:convert_php_arguments, :foo => { :bar => "bat" }).
        should == "array('foo' => array('bar' => 'bat'))"
    end

    it "should convert PHP vars embedded in hashes" do
      view.send(:convert_php_arguments, :foo => { :bar => "$bat" }).
        should == "array('foo' => array('bar' => $bat))"
    end
  end

end
