require 'thor'
require 'meta_wordpress/cli/bootstrap_actions'
require 'active_support/core_ext/string/inflections'

module MetaWordpress
  class CLI < Thor
    include Thor::Actions
    no_tasks { include BootstrapActions }

    def self.source_root
      File.expand_path(File.join('..', 'templates'), File.dirname(__FILE__))
    end

    desc 'bootstrap [THEME]', 'Bootstrap blank meta_wordpress theme with a name of THEME (optional).'
    method_option :skip_theme, :type => :boolean, :default => false, :desc => "Don't create any theme template files."
    def bootstrap(theme_name = destination_root)
      @skip_theme = options[:skip_theme]

      if theme_name.include?('/')
        raise Thor::Error.new "Sorry. '#{theme_name}' seems to be a path. Please provide a folder name."
      end

      empty_directory(theme_name) if theme_name != destination_root

      say 'Creating theme structure ...'

      copy_guard_file
      create_asset_folders
      create_views_folders
      create_view_helpers
      copy_functions_php
      copy_php_lib
      ask_for_theme_details(theme_name)
      create_stylesheet
      copy_screenshot
      copy_theme

      say
      say 'All done!', :green
      say
    end

    desc 'start', 'Start guard and listen for changes.'
    def start
      run 'bundle exec guard -n f'
    end

  private

    def theme_path(file)
      File.join(@theme_path, file)
    end

  end
end
