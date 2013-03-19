require 'spec_helper'
require 'meta_wordpress/cli'

describe MetaWordpress::CLI do

  before(:each) do
    subject.destination_root = project_path
  end

  it "should raise an error if a path is provided" do
    expect{subject.bootstrap("foo/bar")}.
      to raise_error(Thor::Error, /Please provide a folder name/)
  end

  it "should create a theme folder if theme name is passed"

  #

  describe "#add_dependencies" do

    def gemfile; File.join(project_path, 'Gemfile'); end
    def gemfile_content; File.read(gemfile); end

    it "should tell what's going on" do
      output = capture(:stdout) { subject.add_dependencies_to_gemfile }
      output.should include("Gemfile detected, installing dependencies.")
    end

    context do

      before(:each) do
        subject.add_dependencies_to_gemfile
      end

      it "should append the guard-haml gem to the Gemfile" do
        gemfile_content.should include("gem 'guard-haml'")
      end

      it "should append the guard-haml gem to the Gemfile" do
        gemfile_content.should include("gem 'guard-sass'")
      end

      it "should append the guard-haml gem to the Gemfile" do
        gemfile_content.should include("gem 'guard-coffee'")
      end

    end

    describe "without Gemfile" do
      before(:each) { FileUtils.rm gemfile }

      it "should tell what's going on" do
        output = capture(:stdout) { subject.add_dependencies_to_gemfile }
        output.should include("WARNING! No Gemfile found.")
        output.should include("Ensure that the reuqired dependencies are installed properly.")
      end
    end

  end

  describe "#copy_guard_file" do
    it "should copy the guard file" do
      subject.copy_guard_file
      'Guardfile'.should have_been_created_in(project_path)
    end
  end

  describe "#create_asset_folders" do
    before(:each) { subject.create_asset_folders }

    %w(javascripts stylesheets).each do |folder|
      it "should create a folder for #{folder}" do
        folder.should have_been_created_in(project_path)
      end

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
    it "should create a /views folder" do
      subject.create_views_folders
      "views".should have_been_created_in(project_path)
    end
  end

  describe "#create_view_helpers" do
    before(:each) { subject.create_view_helpers }

    it "should create a /views folder" do
      "view_helpers.rb".should have_been_created_in(project_path)
    end

    context "the generated content" do
      pending
    end

    context "the generated content when skipping the theme" do
      pending
    end
  end

  describe "#copy_functions_php" do
    it "should create a functions.php file" do
      subject.copy_functions_php
      "functions.php".should have_been_created_in(project_path)
    end
  end

  describe "#copy_lib" do
    it "should copy the contents of the /lib directory" do
      subject.copy_php_lib
      "lib".should have_been_created_in(project_path)
    end
  end

  describe "#ask_for_theme_details" do
    details = %w(Theme\ name Theme\ url Author(s) Author(s)\ URL Description Version License License\ URL)

    pending
  end

  describe "#create_stylesheet" do
    before(:each) { subject.create_stylesheet }

    it "should create a style.css file" do
      "style.css".should have_been_created_in(project_path)
    end

    it "should contain the theme details" do
      pending
    end
  end

  describe "#copy_theme" do
    before(:each) { subject.copy_theme }

    it "should copy some basic theme files" do
      pending
    end
  end

end
