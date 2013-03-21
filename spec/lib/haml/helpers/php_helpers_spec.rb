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
  end

  describe "#php_e" do
    subject { view.php_e("$foo") }

    it { should == "<?php echo $foo ?>" }
  end

  describe "User helpers" do
    it "should be defined" do

    end
  end

end