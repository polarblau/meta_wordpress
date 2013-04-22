require 'haml'

module Filters
  module Docs
    include ::Haml::Filters::Base

    def render(text)
      "<?php\n/**\n%s\n */\n?>" % text.split("\n").map{|l| " * #{l}" }.join("\n")
    end

  end
end