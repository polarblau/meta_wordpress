require File.expand_path('guard/reload_meta_wordpress.rb', File.dirname(__FILE__))

require 'haml'

# we need to be able to reload the view helper
load File.expand_path('utils/helpers.rb', File.dirname(__FILE__))
require File.expand_path('utils/filters', File.dirname(__FILE__))
