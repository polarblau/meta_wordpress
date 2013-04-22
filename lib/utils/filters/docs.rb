puts "Haml defined: #{defined?(Haml)}"
puts "Haml version: #{Haml::VERSION}"
module Haml
  def self.submodules
    constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
  end
end
puts "Haml submodules: #{Haml.submodules.join(', ')}"

module Utils
  module Filters
    module Docs
      include ::Haml::Filters::Base

      def render(text)
        "<?php\n/**\n%s\n */\n?>" % text.split("\n").map{|l| " * #{l}" }.join("\n")
      end

    end
  end
end

