require 'thor'
require 'meta_wordpress/cli/bootstrap_actions'
require 'active_support/core_ext/string/inflections'

module MetaWordpress
  class CLI < Thor
    include Thor::Actions

    TEMPLATE_PATH = File.expand_path(File.join('..', 'templates'), File.dirname(__FILE__))

    no_tasks do
      include BootstrapActions

      def source_path(file = nil)
        File.join(TEMPLATE_PATH, file)
      end
    end

    def self.source_root
      TEMPLATE_PATH
    end

    desc 'bootstrap [THEME]', 'Bootstrap blank meta_wordpress theme with a name of THEME (optional).'
    method_option :skip_theme, :type => :boolean, :default => false, :desc => "Don't create any theme template files."
    def bootstrap(theme_folder = nil)
      @skip_theme = options[:skip_theme]

      if theme_folder
        empty_directory theme_folder, :verbose => false
        @theme_folder = theme_folder
      else
        @theme_folder = File.basename(destination_root)
      end

      say 'Creating theme structure ...'

      inside(theme_folder || '.') do
        copy_guard_file
        create_asset_folders
        create_views_folder
        create_view_helpers
        copy_functions_php
        copy_php_lib
        ask_for_theme_details
        create_stylesheet
        copy_screenshot
        copy_theme
      end

      say
      say 'All done!', :green
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
