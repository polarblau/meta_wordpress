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

end
