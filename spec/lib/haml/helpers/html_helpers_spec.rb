require 'spec_helper'

class DummyContext; end

describe "Haml::Helpers" do
  let(:view) { DummyContext.new.extend Haml::Helpers }

  describe "#javascript_include_tag" do
    context "single file" do
      subject { haml('= javascript_include_tag "foo"') }
      it { should == "<script src=\"&lt;?php echo get_bloginfo('stylesheet_directory') ?&gt;/javascripts/compiled/foo.js\" type='text/javascript'></script>\n" }
    end

    context "multiple files" do
      subject { haml('= javascript_include_tag "foo", "bar"') }
      it do
        should == <<-eos
<script src=\"&lt;?php echo get_bloginfo('stylesheet_directory') ?&gt;/javascripts/compiled/foo.js\" type='text/javascript'></script>
<script src=\"&lt;?php echo get_bloginfo('stylesheet_directory') ?&gt;/javascripts/compiled/bar.js\" type='text/javascript'></script>
        eos
      end
    end

    context "file with js extension" do
      subject { haml('= javascript_include_tag "foo.js"') }
      it { should == "<script src=\"&lt;?php echo get_bloginfo('stylesheet_directory') ?&gt;/javascripts/compiled/foo.js\" type='text/javascript'></script>\n" }
    end
  end

  describe "#asset_path" do
    context "for javascript files" do
      subject { view.asset_path("foo.js") }
      it { should == "<?php echo get_bloginfo('stylesheet_directory') ?>/javascripts/compiled/foo.js" }
    end

    context "for stylesheets" do
      subject { view.asset_path("foo.css") }
      it { should == "<?php echo get_bloginfo('stylesheet_directory') ?>/stylesheets/compiled/foo.css" }
    end

    context "for image files" do
      subject { view.asset_path("foo.png") }
      it { should == "<?php echo get_bloginfo('stylesheet_directory') ?>/images/foo.png" }
    end

    context "for unknown file types" do
      it "should throw an exception" do
        expect {view.asset_path("foo.exe")}.to raise_error(ArgumentError, "unknown file extension: '.exe'")
      end
    end
  end

  describe "#conditionals_html" do
    it "should render conditional versions of the html tags by default" do
      haml("- conditionals_html do\n  foo").
        should == <<-eos
<!--[if lt IE 7]><html class="ie6"><![endif]-->
<!--[if IE 7]><html class="ie7"><![endif]-->
<!--[if IE 8]><html class="ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<html>
  <!--<![endif]-->
  foo
</html>
        eos
    end

    it "should render attributes" do
      haml("- conditionals_html(:id => 'bar') do\n  foo").
        should == <<-eos
<!--[if lt IE 7]><html id="bar" class="ie6"><![endif]-->
<!--[if IE 7]><html id="bar" class="ie7"><![endif]-->
<!--[if IE 8]><html id="bar" class="ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<html id='bar'>
  <!--<![endif]-->
  foo
</html>
        eos
    end

    it "should render class attributes" do
      haml("- conditionals_html(:class => 'bat') do\n  foo").
        should == <<-eos
<!--[if lt IE 7]><html class="ie6 bat"><![endif]-->
<!--[if IE 7]><html class="ie7 bat"><![endif]-->
<!--[if IE 8]><html class="ie8 bat"><![endif]-->
<!--[if gt IE 8]><!-->
<html class='bat'>
  <!--<![endif]-->
  foo
</html>
        eos
    end
  end

end
