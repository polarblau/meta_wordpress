module Utils
  module Filters
    module PHP
      include ::Haml::Filters::Base

      def render(text)
        "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
      end

    end
  end
end
