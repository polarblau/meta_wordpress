require 'spec_helper'
require 'meta_wordpress/cli'

describe MetaWordpress::CLI do

  before do
    MetaWordpress::CLI.stub(:destination_root).and_return(project_path)
  end

  let(:bootstrap) { MetaWordpress::CLI.new }

  it "should use the current folder's name as theme name if no name provided"

  it "should create a theme folder if theme name is provided"

  #

  describe "#copy_gem_file" do
    before { bootstrap.copy_gem_file }
    subject { "Gemfile" }

    it { should have_been_created_in(project_path) }
  end

  describe "#copy_guard_file" do
    before { bootstrap.copy_guard_file }
    subject { "Guardfile" }

    it { should have_been_created_in(project_path) }
  end

  describe "#create_asset_folders" do
    before(:each) { bootstrap.create_asset_folders }

    %w(javascripts stylesheets).each do |folder|
      subject { folder }
      it { should have_been_created_in(project_path) }

      %w(source compiled).each do |sub_folder|
        it "should create a folder for #{sub_folder} #{folder}" do
          "#{folder}/#{sub_folder}".should have_been_created_in(project_path)
        end

        it "should create a .gitkeep file in #{folder}/#{sub_folder} " do
          "#{folder}/#{sub_folder}/.gitkeep".should have_been_created_in(project_path)
        end
      end

    end
  end

  describe "#create_views_folder" do
    before { bootstrap.create_views_folder }
    subject { "views" }

    it { should have_been_created_in(project_path) }
  end

  describe "#create_view_helpers" do
    before(:each) { bootstrap.create_view_helpers }
    subject { "view_helpers.rb" }

    it { should have_been_created_in(project_path) }
  end

  describe "#copy_functions_php" do
    before { bootstrap.copy_functions_php }
    subject { "functions.php" }

    it { should have_been_created_in(project_path) }
  end

  describe "#copy_lib" do
    before { bootstrap.copy_php_lib }
    subject { 'lib' }

    it { should have_been_created_in(project_path) }
  end

  describe "#ask_for_theme_details" do
    it "should ask for details" do
      bootstrap.instance_variable_set("@theme_folder", 'Foo')
      details = %w(Theme\ name Theme\ url Author(s) Author(s)\ URL Description Version License License\ URL Tags Text\ domain)
      # http://www.arailsdemo.com/posts/57
      $stdin.should_receive(:gets).and_return(*details)
      bootstrap.ask_for_theme_details
    end
  end

  describe "#create_stylesheet" do
    before(:each) { bootstrap.create_stylesheet }
    subject { "style.css" }

    it { should have_been_created_in(project_path) }

    it "should contain the theme details" do
      pending
    end
  end

  describe "#copy_screenshot" do
    before { bootstrap.copy_screenshot }
    subject { 'screenshot.png' }

    it { should have_been_created_in(project_path) }
  end

  describe "#copy_theme" do
    context "theme files" do
      before do
        bootstrap.instance_variable_set("@skip_theme", true)
        bootstrap.copy_theme
      end

      subject { "views/.gitkeep" }

      it { should have_been_created_in(project_path) }
    end
  end

end
