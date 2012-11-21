module Haml
  module Helpers

    def php(text)
      if text.include? "\n"
        "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
      else
        "<?php %s ?>" % text.strip
      end
    end

  end
end

user_helpers = File.expand_path('helpers/haml', Bundler.root)
require user_helpers if File.exists?(user_helpers)
