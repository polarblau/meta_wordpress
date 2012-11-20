# require helpers in project
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
