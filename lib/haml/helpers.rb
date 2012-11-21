module Haml
  module Helpers

    user_helpers_file = File.expand_path('view_helpers.rb', Bundler.root)
    if File.exists? user_helpers_file
      require user_helpers_file
      include ViewHelpers
    end

    def php(text)
      if text.include? "\n"
        "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
      else
        "<?php %s ?>" % text.strip
      end
    end

  end
end
