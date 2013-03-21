require 'spec_helper'

class DummyContext; end

describe "Haml::Helpers" do
  let(:view) { DummyContext.new.extend Haml::Helpers }

  describe "#layout" do
    subject { view.layout(:bar) }
    it { should == "<?php use_layout('bar') ?>" }
  end

  describe "#partial" do
    context "without locals" do
      subject { view.partial(:foo) }
      it { should == "<?php render_partial('foo') ?>" }
    end

    context "with single local variable" do
      subject { view.partial(:foo, :bar => "$bat") }
      it { should == "<?php render_partial('foo', array('bar' => $bat)) ?>" }
    end

    context "with complext local variable set" do
      subject { view.partial(:foo, :bar => "$bat", :baz => ['foo', 1]) }
      it { should == "<?php render_partial('foo', array('bar' => $bat, 'baz' => array('foo', 1))) ?>" }
    end
  end

  describe "#yield_content" do
    context "when fragment name passed" do
      subject { view.yield_content(:foo) }
      it { should == "<?php yield('foo') ?>" }
    end

    context "without fragment name" do
      subject { view.yield_content }
      it { should == "<?php yield() ?>" }
    end
  end

  describe "#content_for" do
    context "content as string, no locals" do
      subject { haml("- content_for(:foo, 'bar')") }
      it { should == "<?php content_for('foo', function() { ?>\nbar\n<?php }) ?>\n" }
    end

    context "content as string, with locals" do
      subject { haml("- content_for(:foo, 'bar', :use => '$bat')") }
      it { should == "<?php content_for('foo', function() use($bat) { ?>\nbar\n<?php }) ?>\n" }
    end

    context "content as string, with multipe locals" do
      subject { haml("- content_for(:foo, 'bar', :use => %w($bat $baz))") }
      it { should == "<?php content_for('foo', function() use($bat, $baz) { ?>\nbar\n<?php }) ?>\n" }
    end

    context "content as block" do
      subject { haml("- content_for(:foo) do\n  %h1 bar") }
      it { should == "<?php content_for('foo', function() { ?>\n<h1>bar</h1>\n<?php }) ?>\n" }
    end

    context "content as block with locals and nested php tag" do
      subject { haml("- content_for(:foo, :use => %w($bat)) do\n  = php_e '$bar'") }
      it { should == "<?php content_for('foo', function() use($bat) { ?>\n<?php echo $bar ?>\n<?php }) ?>\n" }
    end
  end
end
