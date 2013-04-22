require File.expand_path('guard/reload_meta_wordpress.rb', File.dirname(__FILE__))

# we need to be able to reload the view helper
load File.expand_path('haml/helpers.rb', File.dirname(__FILE__))
require File.expand_path('haml/filters', File.dirname(__FILE__))
