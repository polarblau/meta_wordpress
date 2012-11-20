require 'haml'

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

require File.expand_path('helpers/haml', Bundler.root)
