require 'thor'

module MetaWordpress
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path(File.join('..', 'templates'), File.dirname(__FILE__))
    end

    desc 'start', 'Start guard and listen for changes.'
    def start
      run 'bundle exec guard -n f'
    end

    desc 'bootstrap', 'Generate blank WP theme and set it up for Meta Wordpress.'
    def bootstrap

      # Dependencies
      template 'Gemfile.tt', 'Gemfile'
      run 'bundle install'

      # Guard file
      template 'Guardfile.tt', 'Guardfile'

      # Meta language folders
      %w(javascripts stylesheets).each do |folder|
        empty_directory folder
        inside folder do
          empty_directory 'source'
          create_file 'source/.gitkeep'
          empty_directory 'compiled'
          create_file 'compiled/.gitkeep'
        end
      end
      empty_directory 'views'
      # TODO: create version of twentyeleven in HAML and copy?
      create_file 'views/.gitkeep'

      # User view helpers
      template 'view_helpers.tt', 'view_helpers.rb'

      # Theme file
      say "Please provide some details on the theme:"
      @theme_name        = ask("Theme name:")
      @theme_uri         = ask("Theme URL:")
      @theme_author      = ask("Author(s):")
      @theme_author_uri  = ask("Author(s) URL:")
      @theme_description = ask("Description:")
      @theme_version     = ask("Version:") || "0.1"
      @theme_license     = ask("License:")
      @theme_license_uri = ask("License URL:")
      @theme_tags        = ask("Tags (comma separated):")
      @theme_text_domain = ask("Text domain:")
      template 'style.tt', 'style.css'
    end

  end
end
