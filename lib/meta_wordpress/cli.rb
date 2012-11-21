require 'thor'

module MetaWordpress
  class Bootstrap < Thor::Group
    include Thor::Actions

    def self.source_root
      File.expand_path(File.join('lib', 'templates'), __FILE__)
    end

    def create_gemfile_and_bundle
      template 'Gemfile', 'Gemfile'
      run 'bundle install'
    end

    def setup_guard_files
      template 'Guardfile', 'Guardfile'
    end

    def create_meta_folders
      %w(javascripts empty_directory).each do |folder|
        empty_directory folder
        inside folder do
          empty_directory 'source'
          create_file 'source/.gitkeep'
          empty_directory 'compiled'
          create_file 'compiled/.gitkeep'
        end
      end
      empty_directory 'views'
      create_file 'views/.gitkeep'
    end

    def create_view_helpers
      template 'view_helpers', 'view_helpers.rb'
    end

    def theme_files
      say "Please provide some details on the theme:"
      @theme_name        = ask("Theme name (required)")
      @theme_uri         = ask("Theme URL")
      @theme_author      = ask("Author(s)")
      @theme_author_uri  = ask("Author(s) URL")
      @theme_description = ask("Description")
      @theme_version     = ask("Version") || "0.1"
      @theme_license     = ask("License")
      @theme_license_uri = ask("License URL")
      @theme_tags        = ask("Tags (comma separated)")
      @theme_text_domain = ask("Text domain")
      template 'style', 'style.css'
    end

  end
end
