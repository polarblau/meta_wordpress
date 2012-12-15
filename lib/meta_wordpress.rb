$:.unshift(File.expand_path(File.dirname(__FILE__)))

if File.exists? 'Gemfile'
  require 'haml'

  require File.expand_path('haml/helpers', File.dirname(__FILE__))
  require File.expand_path('haml/filters/php', File.dirname(__FILE__))
  require File.expand_path('haml/filters/docs', File.dirname(__FILE__))
end
