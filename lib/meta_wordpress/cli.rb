require 'thor'
require 'active_support/core_ext/string/inflections'

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

    desc 'bootstrap [THEME]', 'Bootstrap blank meta WP theme with a name of THEME (optional).'
    method_option :skip_theme, :type => :boolean, :default => false, :desc => "Don't create any theme template files."
    def bootstrap(theme = destination_root)

      @skip_theme = options[:skip_theme]

      if theme.include? '/'
        raise Thor::Error.new "Sorry. '#{theme}' seems to be a path. Please provide a folder name."
      end

      if theme != destination_root
        empty_directory theme
      end

      inside theme do

        # Dependencies
        copy_file 'Gemfile', 'Gemfile'
        run 'bundle install'

        # Guard file
        copy_file 'Guardfile', 'Guardfile'

        # Meta languages folders
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

        # User view helpers
        template 'view_helpers.tt', 'view_helpers.rb'

        # functions.php
        copy_file 'functions.php', 'functions.php'
        directory 'lib', 'lib'

        # Theme file
        say "Please provide some details on the theme:"
        default_theme_name = File.basename(theme).humanize
        @theme_name        = ask("Theme name (default: '#{default_theme_name}'):\n      > ") || default_theme_name
        @theme_uri         = ask("Theme URL:\n      > ")
        @theme_author      = ask("Author(s):\n      > ")
        @theme_author_uri  = ask("Author(s) URL:\n      > ")
        @theme_description = ask("Description:\n      > ")
        @theme_version     = ask("Version:\n      > ") || "0.1"
        @theme_license     = ask("License:\n      > ")
        @theme_license_uri = ask("License URL:\n      > ")
        @theme_tags        = ask("Tags (comma separated):\n      > ")
        @theme_text_domain = ask("Text domain:\n      > ")

        template 'style.tt', 'style.css'

        if @skip_theme
          inside('views') { create_file('.gitkeep') }
        else
          directory 'theme', 'views'
        end

      end

      say
      say 'All done!', :green
      say

    end

  private

    def theme_path(file)
      File.join(@theme_path, file)
    end

  end
end
