require 'haml'

module Haml
  module Filters
    module Docs
      include Haml::Filters::Base

      def render(text)
        "<?php\n/**\n%s\n */?>" % text.split("\n").map{|l| " * #{l}" }.join("\n")
      end

    end
  end
end

